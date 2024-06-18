import 'package:flutter/material.dart';
import 'package:random_group_generator/constants/all_material.dart';

class StepperWidget extends StatelessWidget {
  final String number;
  final String titleText;
  final bool isActive;
  final bool isCompleted;

  const StepperWidget({
    super.key,
    required this.titleText,
    required this.number,
    this.isActive = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: isActive
              ? AllMaterial.colorBluePrimary
              : AllMaterial.colorGreyPattern,
          child: isCompleted
              ? const Icon(Icons.check, color: AllMaterial.colorWhite)
              : Text(
                  number,
                  style: TextStyle(
                    color: isActive
                        ? AllMaterial.colorWhite
                        : AllMaterial.colorGreyPrimary,
                    fontSize: 14,
                    fontWeight: AllMaterial.fontSemiBold,
                  ),
                ),
        ),
        const SizedBox(height: 10),
        Text(
          titleText,
          style: TextStyle(
            color: isActive ? AllMaterial.colorBlackPrimary : Colors.grey,
            fontSize: 14,
            fontWeight: AllMaterial.fontBold,
          ),
        ),
      ],
    );
  }
}