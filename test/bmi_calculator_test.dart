import 'package:bmi_calc/calculator/bmi_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('checkOutputValues', () {
    BmiCalculator bmiCalculator = new BmiCalculator();
    test('returns correct bmi result for int metric input', () {
      expect(bmiCalculator.calculateMetric(2, 80), equals(80 / (2 * 2)));
    });

    test('returns correct bmi result for dbl metric input', () {
      expect(
          bmiCalculator.calculateMetric(2.5, 80.1), equals(80.1 / (2.5 * 2.5)));
    });

    test('returns correct bmi result for int imperial input', () {
      expect(bmiCalculator.calculateImperial(78, 176),
          equals(703 * 176 / (78 * 78)));
    });

    test('returns correct bmi result for dbl imperial input', () {
      expect(bmiCalculator.calculateImperial(78.2, 176.7),
          equals(703 * 176.7 / (78.2 * 78.2)));
    });
  });

  test('returns correct category name', () {
    BmiCalculator bmiCalculator = new BmiCalculator();
    expect(bmiCalculator.category(15), equals(Category.starving));
    expect(bmiCalculator.category(16.5), equals(Category.thinness));
    expect(bmiCalculator.category(18), equals(Category.underweight));
    expect(bmiCalculator.category(21), equals(Category.normal));
    expect(bmiCalculator.category(27), equals(Category.overweight));
    expect(bmiCalculator.category(31), equals(Category.obesityI));
    expect(bmiCalculator.category(37), equals(Category.obesityII));
    expect(bmiCalculator.category(52), equals(Category.obesityIII));
  });
}
