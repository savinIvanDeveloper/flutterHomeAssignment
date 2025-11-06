import 'package:flutter/material.dart';
import 'package:home_assignment/core/models/contact.dart';
import 'package:home_assignment/widgets/contact_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsDetailsScreen extends StatelessWidget {
  final Contact _contact;
  const ContactsDetailsScreen({super.key, required Contact contact})
    : _contact = contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_contact.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _avatar,
            if (_contact.phones.isNotEmpty) _phonesCard,
            if (_contact.location != null) _locationCard,
              _departmentCard,
          ],
        ),
      ),
    );
  }

  Widget get _avatar {
    return Row(
      children: [
        Spacer(),
        CircleAvatar(
          radius: 50,
          child: _contact.picture == null
              ? Icon(Icons.person, size: 60)
              : ClipOval(child: ContactAvatar(picturePath: _contact.picture!)),
        ),
        Spacer(),
      ],
    );
  }

  Widget get _phonesCard {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            ..._contact.phones.map(
              (phone) => Row(
                children: [
                  Expanded(
                    child: Text(
                      phone,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _callPhoneNumber(phone),
                    child: Icon(Icons.phone),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _locationCard {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Building',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Row(children: [Expanded(child: Text(_contact.location!.building))]),
          ],
        ),
      ),
    );
  }

  Widget get _departmentCard {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            _departmentSubview(
              'Department',
              _contact.department?.depName,
              _contact.department?.depUrl,
            ),
            _departmentSubview(
              'Section',
              _contact.department?.sectionName,
              _contact.department?.sectionUrl,
            ),
            _departmentSubview(
              'Faculty',
              _contact.department?.facultyName,
              _contact.department?.facultyUrl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _departmentSubview(String viewTitle, String? title, String? url) {
    if (title == null) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewTitle,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Row(
          children: [
            Expanded(child: Text(title)),
            if (url != null)
              ElevatedButton(
                onPressed: () => _openWebsite(url),
                child: Icon(Icons.link),
              ),
          ],
        ),
        SizedBox(height: 16)
      ],
    );
  }

  void _openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _callPhoneNumber(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
