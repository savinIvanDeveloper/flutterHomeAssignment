import 'package:flutter/material.dart';
import 'package:home_assignment/app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:home_assignment/features/contacts/provider/contacts_provider.dart';

class SearchHistoryScreen extends StatefulWidget {
  const SearchHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final contactsProvider = context.watch<ContactsProvider>();
    final searchHistory = contactsProvider.searchHistory;
    final appProvider = context.read<AppProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Search History')),
      body: searchHistory.isEmpty
          ? const Center(
              child: Text(
                'No search history yet.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: searchHistory.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final term = searchHistory[index];
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(term),
                  onTap: () {
                    contactsProvider.searchContactBy(name: term);
                    appProvider.setCurrentTabBy(0);
                  },
                );
              },
            ),
    );
  }
}
