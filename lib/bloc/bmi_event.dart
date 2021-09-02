part of 'package:bmi_calc/bloc/bmi_bloc.dart';

@immutable
abstract class BmiEvent {}

class GetBmiResults extends BmiEvent {
  final String weight;
  final String height;

  GetBmiResults(this.weight, this.height);
}

class DropdownChange extends BmiEvent {
  final Units unitSelected;

  DropdownChange(this.unitSelected);
}
