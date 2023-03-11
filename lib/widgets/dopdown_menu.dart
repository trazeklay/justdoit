import 'package:flutter/material.dart';

class DropdownMenu extends StatelessWidget {
  final List<String> options;

  const DropdownMenu({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(),
    );
  }
}
