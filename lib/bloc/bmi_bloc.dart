import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bmi_calc/calculator/bmi_calculator.dart';
import 'package:bmi_calc/model/bmi.dart';
import 'package:bmi_calc/units.dart';
import 'package:meta/meta.dart';

part 'package:bmi_calc/bloc/bmi_event.dart';
part 'package:bmi_calc/bloc/bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(BmiInitial(Units.metric));
  Units currentUnit = Units.metric;

  @override
  Stream<BmiState> mapEventToState(
    BmiEvent event,
  ) async* {
    if (event is DropdownChange) {
      currentUnit = event.unitSelected;
      yield BmiInitial(event.unitSelected);
    } else if (event is GetBmiResults) {
      try {
        if (currentUnit == Units.metric) {
          BmiCalculator bmiCalculator = new BmiCalculator();
          BMI bmi = new BMI(
            bmiCalculator.calculateMetric(event.height!, event.weight!),
            bmiCalculator.category(
              bmiCalculator.calculateMetric(event.height!, event.weight!),
            ),
          );
          yield BmiShowResults(bmi, Units.metric);
        } else if (currentUnit == Units.imperial) {
          BmiCalculator bmiCalculator = new BmiCalculator();
          BMI bmi = new BMI(
            bmiCalculator.calculateImperial(event.height!, event.weight!),
            bmiCalculator.category(
              bmiCalculator.calculateImperial(event.height!, event.weight!),
            ),
          );
          yield BmiShowResults(bmi, Units.imperial);
        }
      } catch (e) {
        yield BmiError(e.toString());
      }
    }
  }
}
