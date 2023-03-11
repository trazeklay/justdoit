import 'dart:math';

import 'package:flutter/material.dart';
import 'package:justdoit/utils/const.dart';
import 'package:justdoit/widgets/avatar/avatar.dart';

class AvatarGroup extends StatelessWidget {
  final List<String> inputArray;

  const AvatarGroup({super.key, required this.inputArray});

  void onAvatarTap() {}

  void onRemainingAvatarsTap() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: inputArray.length * 60.0,
      height: 60.0,
      child: Stack(
        children: List.generate(
          inputArray.length,
          (index) {
            return Positioned(
              left: index * 30.0,
              child: Avatar(
                radius: 20.0,
                onTap: onAvatarTap,
                backgroundColor: AppColors.profilePicColor[4],
                child: Text(
                  Utils.parseName(inputArray[index], 2),
                  style: TextStyle(
                    fontFamily: AppResources.defaultFont,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
