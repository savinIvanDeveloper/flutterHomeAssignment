import 'package:home_assignment/core/utils/api_constants.dart';
import 'package:home_assignment/core/services/network_service.dart';

class ContactsService {
  Future<List> searchContacts(String name) async {
    final data = await NetworkService.instance.get(Api.getContactUrl(name));
    if (data != null) {
      final results = data['results'] as List;
      return results;
    } else {
      throw Exception('Failed load contacts for name $name');
    }
  }
}
