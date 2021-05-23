import 'package:bmi_calculator/screens/bmi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../constants/colors.dart';
import '../widgets/reusable_card.dart';
import '../constants/styles.dart';
import '../widgets/gender_container.dart';
import '../widgets/parameter_container.dart';
import '../widgets/bottom_button.dart';
import '../logic/controllers.dart';
import '../logic/types.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFFEB1555),
        systemNavigationBarDividerColor: Color(0xFFEB1555),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR',
              style: GoogleFonts.roboto(
                  fontSize: 17.5, fontWeight: FontWeight.w800)),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: GenderRow()),
            Expanded(child: Height()),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Parameter(
                      parameterName: "weight",
                      onPlus: () => controller.incrementWeight(),
                      onMinus: () => controller.decrementWeight(),
                      valueGetter: () => controller.getWeight(),
                      unitGetter: () => controller.weightUnit(),
                    ),
                  ),
                  Expanded(
                    child: Parameter(
                      parameterName: "age",
                      onPlus: () => controller.incrementAge(),
                      onMinus: () => controller.decrementAge(),
                      valueGetter: () => controller.getAge(),
                      unitGetter: () => controller.ageUnit(),
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              onTap: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 250),
                    child: BmiPage(),
                    inheritTheme: true,
                    ctx: context),
              ),
              text: "CALCULATE YOUR BMI",
            )
          ],
        ));
  }
}

class Parameter extends StatefulWidget {
  Parameter(
      {Key key,
      @required this.parameterName,
      this.onMinus,
      this.onPlus,
      this.valueGetter,
      this.unitGetter})
      : super(key: key);
  final String parameterName;
  final Function onPlus;
  final Function onMinus;
  final Function valueGetter;
  final Function unitGetter;
  @override
  _ParameterState createState() => _ParameterState();
}

class _ParameterState extends State<Parameter> {
  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: kActiveContainerColor,
      child: ParameterContainer(
        name: widget.parameterName.toUpperCase(),
        heroTag: widget.parameterName.toLowerCase(),
        onPlus: () {
          setState(widget.onPlus);
        },
        onMinus: () {
          setState(widget.onMinus);
        },
        value: widget.valueGetter().toString(),
        unit: widget.unitGetter(),
      ),
    );
  }
}

class Height extends StatefulWidget {
  Height({Key key}) : super(key: key);

  @override
  _HeightState createState() => _HeightState();
}

class _HeightState extends State<Height> {
  bool onChenging;
  @override
  void initState() {
    super.initState();
    onChenging = false;
  }

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: kActiveContainerColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            "HEIGHT",
            style: kLabelTextStyle,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                AnimatedDefaultTextStyle(
                    child: Text(
                      controller.getHeight().toInt().toString(),
                    ),
                    style:
                        onChenging ? kActiveNumberTextStyle : kNumberTextStyle,
                    duration: Duration(milliseconds: 200)),
                Text(controller.heightUnit(), style: kLabelTextStyle)
              ]),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
                thumbColor: kThumbSliderColor,
                activeTrackColor: kActiveSliderColor,
                overlayColor: kOverlaySliderColor,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30)),
            child: Slider(
                value: controller.getHeight(),
                inactiveColor: kInactiveSlideColor,
                min: MIN_HIEGHT,
                max: MAX_HEIGHT,
                onChangeStart: (value) {
                  setState(() {
                    onChenging = true;
                  });
                },
                onChangeEnd: (value) {
                  setState(() {
                    onChenging = false;
                  });
                },
                onChanged: (value) => setState(() {
                      controller.setHeight(value);
                    })),
          )
        ],
      ),
    );
  }
}

class GenderRow extends StatefulWidget {
  GenderRow({Key key}) : super(key: key);

  @override
  _GenderRowState createState() => _GenderRowState();
}

class _GenderRowState extends State<GenderRow> {
  Color maleCardColor;
  Color femaleCardColor;
  @override
  void initState() {
    super.initState();
    maleCardColor = kBottomContainerColor;
    femaleCardColor = kInactiveContainerColor;
  }

  void _toggleGender(GenderType gender) {
    if (gender == controller.getSelectedGender()) return;
    setState(() {
      controller.toggleGender(gender);
    });
  }

  Color _dispatchSelectionColor(GenderType gender) =>
      controller.getSelectedGender() == gender
          ? kBottomContainerColor
          : kInactiveContainerColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ReusableCard(
            onTap: () => _toggleGender(GenderType.MALE),
            gender: GenderType.MALE,
            color: _dispatchSelectionColor(GenderType.MALE),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                  color: _dispatchSelectionColor(GenderType.MALE),
                  borderRadius: BorderRadius.circular(30)),
              child: GenderContainer(
                text: "MALE",
                gender: GenderType.MALE,
                icon: FontAwesomeIcons.mars,
              ),
            ),
          ),
        ),
        Expanded(
            child: ReusableCard(
          onTap: () => _toggleGender(GenderType.FEMALE),
          gender: GenderType.FEMALE,
          color: _dispatchSelectionColor(GenderType.FEMALE),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                  color: _dispatchSelectionColor(GenderType.FEMALE),
                  borderRadius: BorderRadius.circular(30)),
              child: GenderContainer(
                  text: "FEMALE",
                  gender: GenderType.FEMALE,
                  icon: FontAwesomeIcons.venus)),
        ))
      ],
    );
  }
}
