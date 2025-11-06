import 'location.dart';
import 'department.dart';

class Contact {
  final String personId;
  final String name;
  final List<String> phones;
  final List<String> empType;
  String? email;
  Location? location;
  Department? department;
  String? picture;

  Contact({
    required this.personId,
    required this.name,
    required this.phones,
    required this.empType,
    this.email,
    this.location,
    this.department,
    this.picture,
  });

  factory Contact.fromJson(Map<String, dynamic> json) { 
    List phones = json['workphone'] ?? [];
    List emptype = json['emptype'] ?? [];
    Map<String, dynamic> location = json['location'] ?? {};
    Map<String, dynamic> department = json['department'] ?? {};
    return Contact(
    personId: json['person_id'] ?? '',
    name: json['name'] ?? '',
    phones: List<String>.from(phones),
    email: json['email'],
    empType: List<String>.from(emptype),
    location: Location.fromJson(location),
    department: Department.fromJson(department),
    picture: json['picture'] ?? '',
  );
  }
}
