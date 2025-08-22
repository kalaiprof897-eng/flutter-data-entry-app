import 'package:flutter/material.dart';
import '../models/data_entry.dart';
import '../widgets/data_entry_form.dart';

class EditEntryScreen extends StatelessWidget {
  final DataEntry entry;
  final VoidCallback? onEntryUpdated;

  const EditEntryScreen({
    super.key,
    required this.entry,
    this.onEntryUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Entry'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DataEntryForm(
        entry: entry,
        onEntryUpdated: () {
          onEntryUpdated?.call();
          Navigator.pop(context);
        },
      ),
    );
  }
}
