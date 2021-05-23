import 'package:bmi_calculator/logic/controllers.dart';
import 'package:bmi_calculator/logic/types.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/styles.dart';

const double _iconSize = 80.0;

const double _gapSize = 10.0;

class GenderContainer extends StatelessWidget {
  final String text;
  final GenderType gender;
  final IconData icon;

  GenderContainer(
      {@required this.text, @required this.gender, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FaIcon(icon, size: _iconSize),
          SizedBox(
            height: _gapSize,
          ),
          Text(text,
              style: controller.getSelectedGender() != gender
                  ? kLabelTextStyle
                  : kActiveLabelTextStyle)
        ]);
  }
}
