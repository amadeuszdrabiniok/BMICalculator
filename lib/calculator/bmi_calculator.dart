enum Category {
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
  double calculateMetric(double height, double weight) =>
      (weight / (height * height));

  double calculateImperial(double height, double weight) =>
      (weight / (height * height)) * 703;

  Category category(double bmi) {
    if (bmi < 16) {
      return Category.starving;
    } else if (bmi >= 16 && bmi < 16.9) {
      return Category.thinness;
    } else if (bmi >= 17 && bmi < 18.5) {
      return Category.underweight;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return Category.normal;
    } else if (bmi >= 25 && bmi < 29.9) {
      return Category.overweight;
    } else if (bmi >= 30 && bmi < 34.9) {
      return Category.obesityI;
    } else if (bmi >= 35 && bmi < 39.9) {
      return Category.obesityII;
    } else if (bmi >= 40) {
      return Category.obesityIII;
    } else {
      throw Exception('No category error');
    }
  }
}
