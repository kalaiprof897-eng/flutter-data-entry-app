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

  DataEntry copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? company,
    String? position,
    String? category,
    String? priority,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DataEntry(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      position: position ?? this.position,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'DataEntry{id: $id, fullName: $fullName, email: $email, company: $company}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DataEntry && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
