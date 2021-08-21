part of 'bmi_bloc.dart';

@immutable
abstract class BmiState {}

class BmiInitial extends BmiState {
  final unitSelected = 'metric';
}

class BmiShowResults extends BmiState {
  final BMI bmi;

  BmiShowResults(this.bmi);
}

class BmiSelectedMetric extends BmiState {
  final String unitSelected;

  BmiSelectedMetric(this.unitSelected);
}

class BmiSelectedImperial extends BmiState {
  final String unitSelected;

  BmiSelectedImperial(this.unitSelected);
}

class BmiError extends BmiState {
  final String errorMessage;

  BmiError(this.errorMessage);
}
