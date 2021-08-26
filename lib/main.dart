import 'package:bmi_calc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calc/bloc/bmi_bloc.dart';

void main() => runApp(BmiCalc());

class BmiCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => BmiBloc(),
        child: HomePage(),
      ),
    );
  }
}
