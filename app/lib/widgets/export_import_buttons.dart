import 'package:flutter/material.dart';
import '../services/export_import_service.dart';

class ExportImportButtons extends StatefulWidget {
  final VoidCallback? onImportCompleted;

  const ExportImportButtons({
    super.key,
    this.onImportCompleted,
  });

  @override
  State<ExportImportButtons> createState() => _ExportImportButtonsState();
}

class _ExportImportButtonsState extends State<ExportImportButtons> {
  bool _isExporting = false;
  bool _isImporting = false;

  Future<void> _exportData(String format) async {
    setState(() => _isExporting = true);
    
    try {
      String? filePath;
      if (format == 'json') {
        filePath = await ExportImportService.exportToJson();
      } else if (format == 'csv') {
        filePath = await ExportImportService.exportToCsv();
      }
      
      if (mounted && filePath != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data exported successfully to $filePath'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  Future<void> _importData(String format) async {
    setState(() => _isImporting = true);
    
    try {
      int importedCount;
      if (format == 'json') {
        importedCount = await ExportImportService.importFromJson();
      } else if (format == 'csv') {
        importedCount = await ExportImportService.importFromCsv();
      } else {
        throw Exception('Unsupported format');
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported $importedCount entries'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onImportCompleted?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Choose export format:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportData('json');
            },
            child: const Text('JSON'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportData('csv');
            },
            child: const Text('CSV'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Data'),
        content: const Text('Choose import format:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _importData('json');
            },
            child: const Text('JSON'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _importData('csv');
            },
            child: const Text('CSV'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _isExporting ? null : _showExportDialog,
          icon: _isExporting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.download),
          tooltip: 'Export Data',
        ),
        IconButton(
          onPressed: _isImporting ? null : _showImportDialog,
          icon: _isImporting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.upload),
          tooltip: 'Import Data',
        ),
      ],
    );
  }
}
