import 'package:flutter/material.dart';
import '../constants/colors.dart';

const bottomContainerHeight = 80.0;

class BottomButton extends StatefulWidget {
  final Function onTap;
  final String text;
  BottomButton({@required this.onTap, this.text});

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  bool onTapping;
  @override
  void initState() {
    super.initState();
    onTapping = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: kBottomContainerColor,
            spreadRadius: 1.0,
            blurRadius: 3.0,
          )
        ],
      ),
      child: Material(
        color: kBottomContainerColor,
        child: InkWell(
          splashColor: Color(0xFFEB1555),
          highlightColor: Color(0xFFEB1555),
          onHighlightChanged: (status) {
            if (status) {
              setState(() {
                onTapping = true;
              });
            }
            if (!status) {
              setState(() {
                onTapping = false;
              });
            }
          },
          onTap: this.widget.onTap,
          child: Center(
            child: Text(this.widget.text,
                style: TextStyle(
                    color: !onTapping ? Colors.white : Color(0xffd3d3d3),
                    fontSize: 18,
                    letterSpacing: 3)),
          ),
        ),
      ),
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: bottomContainerHeight,
    );
  }
}
