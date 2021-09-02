import 'dart:async';
import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:bmi_calc/calculator/bmi_calculator.dart';
import 'package:bmi_calc/model/bmi.dart';
import 'package:bmi_calc/units.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'package:bmi_calc/bloc/bmi_event.dart';
part 'package:bmi_calc/bloc/bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(BmiInitial(Units.metric));
  Units currentUnit = Units.metric;
  BmiCalculator bmiCalculator = new BmiCalculator();

  @override
  Stream<BmiState> mapEventToState(
    BmiEvent event,
  ) async* {
    if (event is DropdownChange) {
      currentUnit = event.unitSelected;
      yield BmiInitial(event.unitSelected);
    } else if (event is GetBmiResults) {
      try {
        yield BmiShowResults(_getBmiResult(event), currentUnit);
      } catch (e) {
        yield BmiError(e.toString());
      }
    }
  }

  BMI _getBmiResult(GetBmiResults event) {
    double bmiResult = bmiCalculator.calculateBmi(event.height, event.weight);
    CategoryName category = bmiCalculator.getCategory(bmiResult);
    BMI bmi = new BMI(bmiResult, category);

    if (currentUnit == Units.metric) {
      return bmi;
    } else if (currentUnit == Units.imperial) {
      return bmiCalculator.convertToImperial(bmi);
    } else {
      throw Exception('get result unit error');
    }
  }
}
