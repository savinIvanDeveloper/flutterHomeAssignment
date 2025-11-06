import 'package:home_assignment/core/models/contact.dart';
import 'package:home_assignment/features/contacts/data/contacts_service.dart';

class ContactsRepo {
  final ContactsService _service;

  ContactsRepo({ required ContactsService service }) : _service = service;

  Future<List<Contact>> getContactsBy(String name) async {
    final List result = await _service.searchContacts(name);
    final contacts = result.map((e) => Contact.fromJson(e)).toList();
    return contacts;
  }
}
