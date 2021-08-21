part of 'bmi_bloc.dart';

@immutable
abstract class BmiEvent {}

class GetBmiResults extends BmiEvent {
  final double? weight;
  final double? height;

  GetBmiResults(this.weight, this.height);
}

class DropdownChange extends BmiEvent {
  final String unitSelected;

  DropdownChange(this.unitSelected);
}