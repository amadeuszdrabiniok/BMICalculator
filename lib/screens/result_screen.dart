import 'package:bmi_calc/bloc/bmi_bloc.dart';
import 'package:bmi_calc/calculator/bmi_calculator.dart';
import 'package:bmi_calc/model/bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BmiBloc, BmiState>(
          builder: (context, state) {
            if (state is BmiShowResults) {
              return _buildResult(state.bmi);
            } else if (state is BmiError) {
              Navigator.pop(context);
            }
            return Text('error');
          },
        ),
      ),
    );
  }

  Widget _buildResult(BMI bmi) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          bmi.bmiValue.toStringAsFixed(3),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          _returnCategoryName(bmi.category),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0),
        ),
      ],
    );
  }

  String _returnCategoryName(CategoryName category) {
    if (category == CategoryName.starving) {
      return 'Wygłodzenie';
    } else if (category == CategoryName.thinness) {
      return 'Wychudzenie';
    } else if (category == CategoryName.underweight) {
      return 'Niedowaga';
    } else if (category == CategoryName.normal) {
      return 'Waga prawidłowa';
    } else if (category == CategoryName.overweight) {
      return 'Nadwaga';
    } else if (category == CategoryName.obesityI) {
      return 'Otyłość I stopnia';
    } else if (category == CategoryName.obesityII) {
      return 'Otyłość II stopnia';
    } else if (category == CategoryName.obesityIII) {
      return 'Otyłość III stopnia';
    } else {
      throw Exception('no category error');
    }
  }
}
