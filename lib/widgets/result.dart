import 'package:bmi_calculator/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../logic/types.dart';

class Result extends StatelessWidget {
  final String bodyType;
  final String bmi;
  final String indication;
  Result({this.bmi, this.bodyType, this.indication});
  Color _dispatchResultColor() {
    switch (this.bodyType) {
      case OBESE:
        return Colors.red;
      case OVERWEIGHT:
        return Colors.deepOrangeAccent;
      case NORMAL:
        return Colors.teal;
      case UNDERWEIGHT:
        return Colors.redAccent;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            this.bodyType.toUpperCase(),
            style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
                color: _dispatchResultColor()),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Center(
          child:
              Text(this.bmi, style: kNumberTextStyle.apply(fontSizeFactor: 2)),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Text(
              this.indication,
              style: TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Color(0xff32a060),
                borderRadius: BorderRadius.circular(17.5),
              ),
              child: Center(
                  child: Text(
                "Normal BMI : 18.5 > 24.9",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w800),
              )),
            ),
          ],
        )
      ],
    );
  }
}
