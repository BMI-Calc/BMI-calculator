import 'package:bmi_calculator/constants/colors.dart';
import 'package:bmi_calculator/logic/controllers.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final dynamic gender;
  final VoidCallback onTap;
  ReusableCard({@required this.color, this.gender, this.child, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap == null ? () => {} : this.onTap,
      child: Container(
        child: this.child,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(30),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: gender != null
                  ? controller.getSelectedGender() == gender
                      ? kBottomContainerColor
                      : kActiveContainerColor
                  : kActiveContainerColor,
              spreadRadius: 1.0,
              blurRadius: 15.0,
            )
          ],
        ),
      ),
    );
  }
}
