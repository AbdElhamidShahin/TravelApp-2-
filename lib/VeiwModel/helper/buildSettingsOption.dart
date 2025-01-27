import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSettingsOption(BuildContext context,
    {required IconData icon,
      required String title,
      required VoidCallback onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Icon(icon, size: 32),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 22),
      onTap: onPressed,
    ),
  );
}