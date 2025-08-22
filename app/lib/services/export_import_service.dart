import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/data_entry.dart';
import 'database_service.dart';

class ExportImportService {
  static Future<String?> exportToJson() async {
    try {
      final entries = await DatabaseService.instance.getAllDataEntries();
      final jsonData = entries.map((entry) => entry.toMap()).toList();
      final jsonString = const JsonEncoder.withIndent('  ').convert(jsonData);
      
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data_entries_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(jsonString);
      
      return file.path;
    } catch (e) {
      throw Exception('Failed to export data: $e');
    }
  }

  static Future<String?> exportToCsv() async {
    try {
      final entries = await DatabaseService.instance.getAllDataEntries();
      
      final List<List<dynamic>> csvData = [
        [
          'ID',
          'First Name',
          'Last Name',
          'Email',
          'Phone',
          'Company',
          'Position',
          'Category',
          'Priority',
          'Notes',
          'Created At',
          'Updated At'
        ]
      ];
      
      for (final entry in entries) {
        csvData.add([
          entry.id,
          entry.firstName,
          entry.lastName,
          entry.email,
          entry.phone ?? '',
          entry.company ?? '',
          entry.position ?? '',
          entry.category ?? '',
          entry.priority,
          entry.notes ?? '',
          entry.createdAt.toIso8601String(),
          entry.updatedAt.toIso8601String(),
        ]);
      }
      
      final csvString = const ListToCsvConverter().convert(csvData);
      
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data_entries_${DateTime.now().millisecondsSinceEpoch}.csv');
      await file.writeAsString(csvString);
      
      return file.path;
    } catch (e) {
      throw Exception('Failed to export data: $e');
    }
  }

  static Future<int> importFromJson() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result == null || result.files.single.path == null) {
        throw Exception('No file selected');
      }
      
      final file = File(result.files.single.path!);
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonString);
      
      int importedCount = 0;
      for (final item in jsonData) {
        try {
          final entry = DataEntry.fromMap(Map<String, dynamic>.from(item));
          // Remove ID to avoid conflicts and let database assign new IDs
          final newEntry = entry.copyWith(id: null);
          await DatabaseService.instance.insertDataEntry(newEntry);
          importedCount++;
        } catch (e) {
          // Skip invalid entries but continue importing others
          continue;
        }
      }
      
      return importedCount;
    } catch (e) {
      throw Exception('Failed to import data: $e');
    }
  }

  static Future<int> importFromCsv() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      
      if (result == null || result.files.single.path == null) {
        throw Exception('No file selected');
      }
      
      final file = File(result.files.single.path!);
      final csvString = await file.readAsString();
      final List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);
      
      if (csvData.isEmpty) {
        throw Exception('CSV file is empty');
      }
      
      // Skip header row
      int importedCount = 0;
      for (int i = 1; i < csvData.length; i++) {
        try {
          final row = csvData[i];
          if (row.length < 3) continue; // Need at least first name, last name, email
          
          final entry = DataEntry(
            firstName: row[1]?.toString() ?? '',
            lastName: row[2]?.toString() ?? '',
            email: row[3]?.toString() ?? '',
            phone: row[4]?.toString().isEmpty == true ? null : row[4]?.toString(),
            company: row[5]?.toString().isEmpty == true ? null : row[5]?.toString(),
            position: row[6]?.toString().isEmpty == true ? null : row[6]?.toString(),
            category: row[7]?.toString().isEmpty == true ? null : row[7]?.toString(),
            priority: row[8]?.toString() ?? 'medium',
            notes: row[9]?.toString().isEmpty == true ? null : row[9]?.toString(),
          );
          
          if (entry.firstName.isNotEmpty && entry.lastName.isNotEmpty && entry.email.isNotEmpty) {
            await DatabaseService.instance.insertDataEntry(entry);
            importedCount++;
          }
        } catch (e) {
          // Skip invalid entries but continue importing others
          continue;
        }
      }
      
      return importedCount;
    } catch (e) {
      throw Exception('Failed to import data: $e');
    }
  }
}
