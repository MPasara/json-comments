import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppDrawerTile extends StatelessWidget {
  const AppDrawerTile({
    super.key,
    required this.onTap,
    required this.leadingIconPath,
    required this.tileText,
    required this.selected,
  });

  final Function() onTap;
  final String leadingIconPath;
  final String tileText;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: selected ? Colors.deepPurple.shade100 : Colors.blue,
      leading: SvgPicture.asset(leadingIconPath, width: 28, height: 28),
      title: Text(tileText),
      onTap: onTap,
    );
  }
}
