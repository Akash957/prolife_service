import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const GlobalListTile({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}