import 'package:flutter/material.dart';

class SearchResultListTile extends StatelessWidget {
  final Widget title, subtitle, trailing, leading;
  final VoidCallback onTap;

  const SearchResultListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required this.leading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      leading: leading,
      onTap: onTap,
    );
  }
}
