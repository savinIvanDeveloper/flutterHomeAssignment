import 'package:flutter/material.dart';
import 'package:home_assignment/core/utils/api_constants.dart';

class ContactAvatar extends StatelessWidget {
  final String _picturePath;

  const ContactAvatar({super.key, required String picturePath})
    : _picturePath = picturePath;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      Api.getPhotoUrl(_picturePath),
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (_, _, _) {
        return Icon(Icons.person);
      },
    );
  }
}
