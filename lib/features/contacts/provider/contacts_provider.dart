import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_assignment/core/utils/logger_helper.dart';
import 'package:home_assignment/features/contacts/data/contacts_repo.dart';
import 'package:home_assignment/core/models/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsProvider extends ChangeNotifier {
  final ContactsRepo _repo;

  ContactsProvider({required ContactsRepo repo}) : _repo = repo;
  List<Contact> _contacts = [];
  List<String> _searchHistory = [];
  String? _searchText;
  bool _isLoading = false;
  String? _error;
  int _latesRequestId = 0;
  Timer? _debounce;

  List<Contact> get contacts => _contacts;
  List<String> get searchHistory => _searchHistory;
  String? get searchText => _searchText;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void searchContactBy({required String name}) {
    _isLoading = true;
    _searchText = name;
    notifyListeners();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search(name);
    });
  }

  Future<void> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList('search_history') ?? [];
    notifyListeners();
  }

  void cancelSearch() {
    _searchText = null;
    _debounce?.cancel();
    _contacts = [];
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  // MARK: Private methods

  Future<void> _search(String name) async {
    if (name.length < 3) {
      _isLoading = false;
      _contacts = [];
      notifyListeners();
      return;
    }

    _addHistory(name);
    final currentRequestId = ++_latesRequestId;
    _error = null;
    notifyListeners();

    try {
      final result = await _repo.getContactsBy(name);
      if (currentRequestId != _latesRequestId) return;
      _contacts = result;
    } catch (e) {
      if (currentRequestId != _latesRequestId) return;
      logger.e(e.toString());
      _error = 'Something went wrong.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _addHistory(String name) async {
    _searchHistory.remove(name);
    _searchHistory.insert(0, name);
    if (_searchHistory.length > 10) {
      _searchHistory = _searchHistory.sublist(0, 10);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', _searchHistory);
  }
}
