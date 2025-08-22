# Data Entry App

A comprehensive Flutter application for managing data entries with full CRUD operations, search functionality, and data export/import capabilities.

## Features

- **Add New Entries**: Create new data entries with comprehensive form validation
- **View & Manage Data**: Browse all entries in a clean, organized list view
- **Search & Filter**: Find entries quickly using search and category filters
- **Edit & Delete**: Update existing entries or remove them as needed
- **Data Export**: Export your data to JSON or CSV formats
- **Data Import**: Import data from JSON or CSV files
- **Local Storage**: All data is stored locally using SQLite database
- **Modern UI**: Clean, Material Design 3 interface with responsive layout

## Data Fields

Each entry supports the following fields:
- First Name (required)
- Last Name (required)
- Email (required, validated)
- Phone Number
- Company
- Position
- Category (Customer, Supplier, Employee, Partner)
- Priority (Low, Medium, High)
- Notes
- Timestamps (Created/Updated)

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio or VS Code with Flutter extensions

### Installation

1. Clone or download the project
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

### Dependencies

- `sqflite`: Local SQLite database
- `path`: File path utilities
- `intl`: Date formatting
- `file_picker`: File selection for import
- `path_provider`: Access to device directories
- `csv`: CSV file processing

## Usage

### Adding Entries
1. Open the "Add Entry" tab
2. Fill in the required fields (First Name, Last Name, Email)
3. Optionally add additional information
4. Tap "Add Entry" to save

### Viewing & Managing Data
1. Switch to the "View Data" tab
2. Browse all entries in the list
3. Use search bar to find specific entries
4. Filter by category using the dropdown
5. Tap edit icon to modify an entry
6. Tap delete icon to remove an entry

### Export/Import
- **Export**: Tap the download icon in the app bar, choose JSON or CSV format
- **Import**: Tap the upload icon in the app bar, select file format and choose file

## File Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── data_entry.dart      # Data model
├── screens/
│   ├── home_screen.dart     # Main app screen with tabs
│   └── edit_entry_screen.dart # Edit entry screen
├── services/
│   ├── database_service.dart     # SQLite database operations
│   └── export_import_service.dart # Data export/import
└── widgets/
    ├── data_entry_form.dart      # Form for adding/editing entries
    ├── data_entry_list.dart      # List view for displaying entries
    ├── search_filter_bar.dart    # Search and filter controls
    └── export_import_buttons.dart # Export/import UI controls
```

## Database Schema

The app uses SQLite with the following table structure:

```sql
CREATE TABLE data_entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  firstName TEXT NOT NULL,
  lastName TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT,
  company TEXT,
  position TEXT,
  category TEXT,
  priority TEXT DEFAULT 'medium',
  notes TEXT,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL
)
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source and available under the MIT License.
