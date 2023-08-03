import 'package:flutter/material.dart';

class AccountOptionWidget extends StatelessWidget {
  const AccountOptionWidget(
      {super.key, required this.title, required this.onTapp});
  final String title;
  final Function onTapp;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapp.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
