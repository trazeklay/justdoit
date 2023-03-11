import 'package:flutter/material.dart';
import 'package:justdoit/utils/const.dart';

class Avatar extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Widget child;
  final double? radius;

  const Avatar({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    this.radius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    radius ?? 30.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: radius,
          foregroundColor: AppColors.white,
          backgroundColor: backgroundColor,
          child: child,
        ),
      ),
    );
  }
}
