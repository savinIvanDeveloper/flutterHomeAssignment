import 'package:flutter/material.dart';
import 'package:home_assignment/core/models/contact.dart';
import 'package:home_assignment/widgets/contact_avatar.dart';

class ContactCard extends StatelessWidget {
  final Contact _contact;
  final VoidCallback _onTapReadMore;

  const ContactCard({
    super.key,
    required Contact contact,
    required VoidCallback onTapReadMore,
  }) : _contact = contact,
       _onTapReadMore = onTapReadMore;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: GestureDetector(
          onTap: _onTapReadMore,
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: _contact.picture == null
                    ? const Icon(Icons.person, size: 32)
                    : ClipOval(
                  child: ContactAvatar(picturePath: _contact.picture!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _contact.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (_contact.phones.isNotEmpty)
                    ..._contact.phones.map((phone) => Text(phone)),
                    if (_contact.location != null)
                    Text(_contact.location!.building),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
