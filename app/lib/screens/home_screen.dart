import 'package:flutter/material.dart';
import '../models/data_entry.dart';
import '../services/database_service.dart';
import '../widgets/data_entry_form.dart';
import '../widgets/data_entry_list.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/export_import_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  List<DataEntry> _dataEntries = [];
  List<DataEntry> _filteredEntries = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadDataEntries();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDataEntries() async {
    setState(() => _isLoading = true);
    try {
      final entries = await DatabaseService.instance.getAllDataEntries();
      setState(() {
        _dataEntries = entries;
        _filteredEntries = entries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  void _filterEntries() {
    setState(() {
      _filteredEntries = _dataEntries.where((entry) {
        final matchesSearch = _searchQuery.isEmpty ||
            entry.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            entry.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (entry.company?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
            (entry.position?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);

        final matchesCategory = _selectedCategory == null ||
            _selectedCategory!.isEmpty ||
            entry.category == _selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _filterEntries();
  }

  void _onCategoryChanged(String? category) {
    _selectedCategory = category;
    _filterEntries();
  }

  void _onEntryAdded() {
    _loadDataEntries();
    _tabController.animateTo(1); // Switch to data list tab
  }

  void _onEntryUpdated() {
    _loadDataEntries();
  }

  void _onEntryDeleted() {
    _loadDataEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Entry App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          ExportImportButtons(
            onImportCompleted: _loadDataEntries,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.add),
              text: 'Add Entry',
            ),
            Tab(
              icon: Icon(Icons.list),
              text: 'View Data',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Add Entry Tab
          DataEntryForm(
            onEntryAdded: _onEntryAdded,
          ),
          // View Data Tab
          Column(
            children: [
              SearchFilterBar(
                onSearchChanged: _onSearchChanged,
                onCategoryChanged: _onCategoryChanged,
                selectedCategory: _selectedCategory,
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : DataEntryList(
                        entries: _filteredEntries,
                        onEntryUpdated: _onEntryUpdated,
                        onEntryDeleted: _onEntryDeleted,
                      ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              onPressed: () => _tabController.animateTo(0),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
