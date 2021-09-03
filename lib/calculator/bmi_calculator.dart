import 'package:bmi_calc/bloc/bmi_bloc.dart';
import 'package:bmi_calc/errors/errors.dart';
import 'package:bmi_calc/model/bmi.dart';

import '../units.dart';

enum CategoryName {
  starving,
  thinness,
  underweight,
  normal,
  overweight,
  obesityI,
  obesityII,
  obesityIII,
}

class BmiCalculator {
  double calculateBmi(String height, String weight, Units selectedUnit) {
    double parsedWeight = _parseInput(weight, selectedUnit, Parameters.weight);
    double parsedHeight = _parseInput(height, selectedUnit, Parameters.height);

    return (parsedWeight / (parsedHeight * parsedHeight));
  }

  BMI convertToImperial(BMI bmiToConvert) {
    double bmiValue = bmiToConvert.bmiValue * 703;
    CategoryName categoryName = getCategory(bmiValue);

    return BMI(bmiValue, categoryName);
  }

  double _parseInput(String input, Units selectedUnit, Parameters parameter) {
    if (double.tryParse(input.replaceAll(',', '.')) != null) {
      double parsedInput = double.parse(input.replaceAll(',', '.'));

      if (_validateInput(parsedInput, selectedUnit, parameter)) {
        return parsedInput;
      } else {
        throw CannotValidateException();
      }
    } else {
      throw CannotParseInputException();
    }
  }

  bool _validateInput(
      double input, Units unitOfParameter, Parameters parameter) {
    if (input <= 0) {
      throw ParsedValueLessEqZeroException();
    } else if (unitOfParameter == Units.metric &&
        parameter == Parameters.weight &&
        input > 635) {
      //heaviest person in history
      throw WeightTooHighException();
    } else if (unitOfParameter == Units.metric &&
        parameter == Parameters.height &&
        input > 2.72) {
      //tallest person in history
      throw HeightTooHighException();
    } else if (unitOfParameter == Units.imperial &&
        parameter == Parameters.weight &&
        input > 294) {
      //heaviest person in history
      throw WeightTooHighException();
    } else if (unitOfParameter == Units.imperial &&
        parameter == Parameters.height &&
        input > 107.09) {
      //tallest person in history
      throw HeightTooHighException();
    } else {
      return true;
    }
  }

  CategoryName getCategory(double bmi) {
    if (bmi > 0 && bmi < 16) {
      return CategoryName.starving;
    } else if (bmi >= 16 && bmi < 16.9) {
      return CategoryName.thinness;
    } else if (bmi >= 17 && bmi < 18.5) {
      return CategoryName.underweight;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return CategoryName.normal;
    } else if (bmi >= 25 && bmi < 29.9) {
      return CategoryName.overweight;
    } else if (bmi >= 30 && bmi < 34.9) {
      return CategoryName.obesityI;
    } else if (bmi >= 35 && bmi < 39.9) {
      return CategoryName.obesityII;
    } else if (bmi >= 40) {
      return CategoryName.obesityIII;
    } else {
      throw NoCategoryException();
    }
  }
}
