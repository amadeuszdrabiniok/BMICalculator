part of 'package:bmi_calc/bloc/bmi_bloc.dart';

@immutable
abstract class BmiState {}

class BmiInitial extends BmiState {
  final Units unitSelected;

  BmiInitial(this.unitSelected);
}

class BmiShowResults extends BmiState {
  final BMI bmi;
  final Units unitSelected;

  BmiShowResults(this.bmi, this.unitSelected);
}

class BmiError extends BmiState {
  final String errorMessage;

  BmiError(this.errorMessage);
}
