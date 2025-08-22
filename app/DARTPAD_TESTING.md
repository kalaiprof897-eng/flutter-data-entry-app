# DartPad Testing Guide

## What is DartPad?
DartPad is an online Dart editor that runs in your browser. While it can't run the full Flutter app, you can test individual components and logic.

## Access DartPad
Visit: https://dartpad.dev

## Testing App Components

### 1. Test Data Model
Copy and paste this code to test the DataEntry model:

```dart
// Data Entry Model Test
class DataEntry {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? company;
  final String? position;
  final String? category;
  final String priority;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  DataEntry({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.company,
    this.position,
    this.category,
    this.priority = 'medium',
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'company': company,
      'position': position,
      'category': category,
      'priority': priority,
      'notes': notes,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory DataEntry.fromMap(Map<String, dynamic> map) {
    return DataEntry(
      id: map['id']?.toInt(),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      company: map['company'],
      position: map['position'],
      category: map['category'],
      priority: map['priority'] ?? 'medium',
      notes: map['notes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
    );
  }
}

void main() {
  // Test creating a data entry
  final entry = DataEntry(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    phone: '+1234567890',
    company: 'Tech Corp',
    position: 'Developer',
    category: 'employee',
    priority: 'high',
    notes: 'Senior Flutter developer',
  );

  print('Full Name: ${entry.fullName}');
  print('Email: ${entry.email}');
  print('Company: ${entry.company}');
  print('Priority: ${entry.priority}');
  
  // Test serialization
  final map = entry.toMap();
  print('\nSerialized to Map:');
  print(map);
  
  // Test deserialization
  final newEntry = DataEntry.fromMap(map);
  print('\nDeserialized Entry:');
  print('Name: ${newEntry.fullName}');
  print('Email: ${newEntry.email}');
}
```

### 2. Test Form Validation Logic
```dart
// Form Validation Test
class FormValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
  
  static String? validatePhone(String? phone) {
    if (phone != null && phone.isNotEmpty) {
      if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone)) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }
}

void main() {
  // Test email validation
  print('Email Tests:');
  print(FormValidator.validateEmail(''));
  print(FormValidator.validateEmail('invalid-email'));
  print(FormValidator.validateEmail('valid@example.com'));
  
  // Test required field validation
  print('\nRequired Field Tests:');
  print(FormValidator.validateRequired('', 'First Name'));
  print(FormValidator.validateRequired('John', 'First Name'));
  
  // Test phone validation
  print('\nPhone Tests:');
  print(FormValidator.validatePhone('+1234567890'));
  print(FormValidator.validatePhone('invalid-phone'));
  print(FormValidator.validatePhone(''));
}
```

### 3. Test Search/Filter Logic
```dart
// Search and Filter Test
class DataEntry {
  final String firstName;
  final String lastName;
  final String email;
  final String? company;
  final String? category;
  
  DataEntry({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.company,
    this.category,
  });
  
  String get fullName => '$firstName $lastName';
}

class DataFilter {
  static List<DataEntry> filterEntries(
    List<DataEntry> entries,
    String searchQuery,
    String? categoryFilter,
  ) {
    return entries.where((entry) {
      final matchesSearch = searchQuery.isEmpty ||
          entry.fullName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          entry.email.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (entry.company?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);

      final matchesCategory = categoryFilter == null ||
          categoryFilter.isEmpty ||
          entry.category == categoryFilter;

      return matchesSearch && matchesCategory;
    }).toList();
  }
}

void main() {
  // Sample data
  final entries = [
    DataEntry(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@techcorp.com',
      company: 'TechCorp',
      category: 'employee',
    ),
    DataEntry(
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane@supplier.com',
      company: 'Supplier Inc',
      category: 'supplier',
    ),
    DataEntry(
      firstName: 'Bob',
      lastName: 'Johnson',
      email: 'bob@customer.com',
      company: 'Customer Co',
      category: 'customer',
    ),
  ];

  // Test search functionality
  print('Search for "john":');
  final searchResults = DataFilter.filterEntries(entries, 'john', null);
  for (final entry in searchResults) {
    print('${entry.fullName} - ${entry.email}');
  }

  // Test category filter
  print('\nFilter by "supplier":');
  final categoryResults = DataFilter.filterEntries(entries, '', 'supplier');
  for (final entry in categoryResults) {
    print('${entry.fullName} - ${entry.category}');
  }

  // Test combined search and filter
  print('\nSearch "co" with category "customer":');
  final combinedResults = DataFilter.filterEntries(entries, 'co', 'customer');
  for (final entry in combinedResults) {
    print('${entry.fullName} - ${entry.company}');
  }
}
```

## Limitations of DartPad
- Cannot test Flutter UI components
- No database functionality
- No file system access
- No external packages

## Benefits
- Quick logic testing
- No setup required
- Instant feedback
- Share code snippets easily
