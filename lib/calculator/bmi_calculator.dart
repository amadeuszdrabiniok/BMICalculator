import 'package:bmi_calc/model/bmi.dart';

enum CategoryName {
  starving,
  thinness,
  underweight,
  normal,
  overweight,
  obesityI,
  obesityII,
  obesityIII
}

class BmiCalculator {
  double calculateBmi(double height, double weight) =>
      (weight / (height * height));

  BMI convertToImperial(BMI bmiToConvert) {
    double bmiValue = bmiToConvert.bmiValue * 703;
    CategoryName categoryName = getCategory(bmiValue);

    return BMI(bmiValue, categoryName);
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
      throw Exception('No category error');
    }
  }
}
