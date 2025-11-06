import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_assignment/features/contacts/provider/contacts_provider.dart';
import 'package:home_assignment/features/contacts/screens/contact_details_screen.dart';
import 'package:home_assignment/widgets/contact_card.dart';

class SearchContactScreen extends StatefulWidget {
  const SearchContactScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchContactState();
}

class _SearchContactState extends State<SearchContactScreen> {
  late final TextEditingController _textController;
  late final ContactsProvider _contactsProvider;
  final _focuseNode = FocusNode();
  bool _isSearching = false;

  @override
  void dispose() {
    _textController.dispose();
    _focuseNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _contactsProvider = context.read<ContactsProvider>();
    _textController = TextEditingController(text: _contactsProvider.searchText);
    _isSearching = _contactsProvider.searchText?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactsProvider>();
    final contacts = provider.contacts;
    final searchText = provider.searchText ?? '';

    Widget content = Container();

    if (provider.error != null) {
      content = Padding(
        padding: EdgeInsets.all(16),
        child: Text(provider.error!),
      );
    } else if (searchText.isEmpty || searchText.length < 3) {
      content = Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Start typing in search bar (${3 - (provider.searchText?.length ?? 0)} characters more)',
        ),
      );
    } else if (!provider.isLoading && contacts.isEmpty) {
      content = Padding(
        padding: EdgeInsets.all(16),
        child: Text('No results found'),
      );
    } else {
      content = Expanded(
        child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ContactCard(
              contact: contact,
              onTapReadMore: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContactsDetailsScreen(contact: contact),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(16), child: _searchBar),
          if (provider.isLoading) const LinearProgressIndicator(),
          content,
        ],
      ),
    );
  }

  Widget get _searchBar {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            focusNode: _focuseNode,
            decoration: InputDecoration(
              hintText: 'Search contacts...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onTap: () => setState(() {
              _isSearching = true;
            }),
            onChanged: _onSearchChange,
          ),
        ),
        if (_isSearching)
          IconButton(onPressed: _cancelSearch, icon: Icon(Icons.close)),
      ],
    );
  }

  void _cancelSearch() {
    setState(() {
      _textController.clear();
      _isSearching = false;
    });
    _focuseNode.unfocus();
    _contactsProvider.cancelSearch();
  }

  void _onSearchChange(String searchText) {
    _contactsProvider.searchContactBy(name: searchText);
  }
}
