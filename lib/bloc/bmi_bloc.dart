import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmi_calc/calculator/bmi_calculator.dart';
import 'package:bmi_calc/model/bmi.dart';
import 'package:bmi_calc/units.dart';
import 'package:meta/meta.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(BmiInitial());
  var currentUnit = Units.metric;

  @override
  Stream<BmiState> mapEventToState(
    BmiEvent event,
  ) async* {
    if (event is DropdownChange) {
      if (event.unitSelected == Units.imperial) {
        currentUnit = event.unitSelected;
        yield BmiSelectedImperial(event.unitSelected);
      } else if (event.unitSelected == Units.metric) {
        currentUnit = event.unitSelected;
        yield BmiSelectedMetric(event.unitSelected);
      }
    } else if (event is GetBmiResults) {
      try {
        if (currentUnit == Units.metric) {
          BMI bmi = new BMI(
              BmiCalculator().calculateMetric(event.height!, event.weight!),
              BmiCalculator().category(BmiCalculator()
                  .calculateMetric(event.height!, event.weight!)));
          yield BmiShowResults(bmi);
        } else if (currentUnit == Units.imperial) {
          BMI bmi = new BMI(
              BmiCalculator().calculateImperial(event.height!, event.weight!),
              BmiCalculator().category(BmiCalculator()
                  .calculateImperial(event.height!, event.weight!)));
          yield BmiShowResults(bmi);
        }
      } catch (e) {
        yield BmiError(e.toString());
      }
    }
  }
}
