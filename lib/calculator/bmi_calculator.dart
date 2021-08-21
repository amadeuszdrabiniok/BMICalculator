import 'package:bmi_calc/model/bmi.dart';

class BmiCalculator {
  static double calculateMetric(double height, double weight) =>
      (weight / (height * height));

  static double calculateImperial(double height, double weight) =>
      (weight / (height * height)) * 703;

  static String category(double bmi) {
    if (bmi < 16) {
      return 'Wygłodzenie';
    } else if (bmi >= 16 && bmi < 16.9) {
      return 'Wychudzenie';
    } else if (bmi >= 17 && bmi < 18.5) {
      return 'Niedowaga';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Waga prawidłowa';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Nadwaga';
    } else if (bmi >= 30 && bmi < 34.9) {
      return 'Otyłość I stopnia';
    } else if (bmi >= 35 && bmi < 39.9) {
      return 'Otyłość II stopnia';
    } else if (bmi >= 40) {
      return 'Otyłość III stopnia';
    } else {
      return 'błąd';
    }
  }
}
