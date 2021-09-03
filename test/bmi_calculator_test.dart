import 'dart:math';

import 'package:bmi_calc/calculator/bmi_calculator.dart';
import 'package:bmi_calc/errors/errors.dart';
import 'package:bmi_calc/model/bmi.dart';
import 'package:bmi_calc/units.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  BmiCalculator bmiCalculator = new BmiCalculator();

  group('check output values', () {
    test('returns correct bmi result', () {
      expect(bmiCalculator.calculateBmi('2', '80', Units.metric),
          equals(80 / (2 * 2)));
      expect(bmiCalculator.calculateBmi('1.5', '80', Units.metric),
          equals(80 / (1.5 * 1.5)));
      expect(bmiCalculator.calculateBmi('1,2', '80', Units.metric),
          equals(80 / (1.2 * 1.2)));
      expect(bmiCalculator.calculateBmi('1', '80', Units.metric),
          equals(80 / (1 * 1)));
      expect(bmiCalculator.calculateBmi('0.5', '80', Units.metric),
          equals(80 / (0.5 * 0.5)));
      expect(bmiCalculator.calculateBmi('0,3', '80', Units.metric),
          equals(80 / (0.3 * 0.3)));

      expect(bmiCalculator.calculateBmi('2', '20.4', Units.metric),
          equals(20.4 / (2 * 2)));
      expect(bmiCalculator.calculateBmi('1.5', '30,1', Units.metric),
          equals(30.1 / (1.5 * 1.5)));
      expect(bmiCalculator.calculateBmi('1.2', '40', Units.metric),
          equals(40 / (1.2 * 1.2)));
      expect(bmiCalculator.calculateBmi('1', '50.66', Units.metric),
          equals(50.66 / (1 * 1)));
      expect(bmiCalculator.calculateBmi('0,5', '60.113', Units.metric),
          equals(60.113 / (0.5 * 0.5)));
      expect(bmiCalculator.calculateBmi('0,3', '70,64', Units.metric),
          equals(70.64 / (0.3 * 0.3)));

      expect(bmiCalculator.calculateBmi('2', '20,4', Units.metric),
          equals(20.4 / (2 * 2)));
      expect(bmiCalculator.calculateBmi('2', '30', Units.metric),
          equals(30 / (2 * 2)));
      expect(bmiCalculator.calculateBmi('1.2', '40,33', Units.metric),
          equals(40.33 / (1.2 * 1.2)));
      expect(bmiCalculator.calculateBmi('1', '50', Units.metric),
          equals(50 / (1 * 1)));
      expect(bmiCalculator.calculateBmi('0.5', '60.441', Units.metric),
          equals(60.441 / (0.5 * 0.5)));
      expect(bmiCalculator.calculateBmi('0.3', '70', Units.metric),
          equals(70 / (0.3 * 0.3)));
    });

    test('correctly converts to imperial', () {
      expect(
          bmiCalculator
              .convertToImperial(BMI(
                  bmiCalculator.calculateBmi('70', '80', Units.imperial),
                  CategoryName.normal))
              .bmiValue,
          equals(BMI(80 / (70 * 70) * 703, CategoryName.normal).bmiValue));

      expect(
          bmiCalculator
              .convertToImperial(BMI(
                  bmiCalculator.calculateBmi(
                      '80,23', '100,234', Units.imperial),
                  CategoryName.normal))
              .bmiValue,
          equals(BMI(100.234 / (80.23 * 80.23) * 703, CategoryName.normal)
              .bmiValue));

      expect(
          bmiCalculator
              .convertToImperial(BMI(
                  bmiCalculator.calculateBmi('55.11', '70,334', Units.imperial),
                  CategoryName.normal))
              .bmiValue,
          equals(BMI(70.334 / (55.11 * 55.11) * 703, CategoryName.normal)
              .bmiValue));
    });

    test('returns correct category', () {
      expect(bmiCalculator.getCategory(15), equals(CategoryName.starving));
      expect(bmiCalculator.getCategory(16.5), equals(CategoryName.thinness));
      expect(bmiCalculator.getCategory(18), equals(CategoryName.underweight));
      expect(bmiCalculator.getCategory(21), equals(CategoryName.normal));
      expect(bmiCalculator.getCategory(27), equals(CategoryName.overweight));
      expect(bmiCalculator.getCategory(31), equals(CategoryName.obesityI));
      expect(bmiCalculator.getCategory(37), equals(CategoryName.obesityII));
      expect(bmiCalculator.getCategory(52), equals(CategoryName.obesityIII));
    });
  });

  group('validate input data', () {
    test('throws Exception on height validation', () {
      expect(() => bmiCalculator.calculateBmi('-3', '50', Units.metric),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));

      expect(() => bmiCalculator.calculateBmi('2,722', '50', Units.metric),
          throwsA(isInstanceOf<HeightTooHighException>()));

      expect(() => bmiCalculator.calculateBmi('0', '50', Units.metric),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));

      expect(() => bmiCalculator.calculateBmi('-288.43', '50', Units.imperial),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));

      expect(() => bmiCalculator.calculateBmi('0', '50', Units.imperial),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));

      expect(() => bmiCalculator.calculateBmi('107,9999', '50', Units.imperial),
          throwsA(isInstanceOf<HeightTooHighException>()));
    });

    test('throws Exception on weight validation', () {
      expect(() => bmiCalculator.calculateBmi('1', '0', Units.metric),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));

      expect(() => bmiCalculator.calculateBmi('1', '-56', Units.metric),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));

      expect(() => bmiCalculator.calculateBmi('1', '635,00001', Units.metric),
          throwsA(isInstanceOf<WeightTooHighException>()));

      expect(() => bmiCalculator.calculateBmi('70', '294.0001', Units.imperial),
          throwsA(isInstanceOf<WeightTooHighException>()));

      expect(() => bmiCalculator.calculateBmi('70', '0', Units.imperial),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));

      expect(() => bmiCalculator.calculateBmi('70', '-33', Units.imperial),
          throwsA(isInstanceOf<ParsedValueLessEqZeroException>()));
    });

    test('throws Exception on parsing', () {
      expect(() => bmiCalculator.calculateBmi('r1', '43', Units.metric),
          throwsA(isInstanceOf<CannotParseInputException>()));

      expect(() => bmiCalculator.calculateBmi('1', '+r0', Units.metric),
          throwsA(isInstanceOf<CannotParseInputException>()));

      expect(() => bmiCalculator.calculateBmi('t', 'b@', Units.metric),
          throwsA(isInstanceOf<CannotParseInputException>()));

      expect(() => bmiCalculator.calculateBmi('70e', '200', Units.imperial),
          throwsA(isInstanceOf<CannotParseInputException>()));

      expect(() => bmiCalculator.calculateBmi('70', '01afg', Units.imperial),
          throwsA(isInstanceOf<CannotParseInputException>()));

      expect(() => bmiCalculator.calculateBmi('sf', '-rg', Units.imperial),
          throwsA(isInstanceOf<CannotParseInputException>()));
    });

    test('throws Exception on category', () {
      expect(() => bmiCalculator.getCategory(0),
          throwsA(isInstanceOf<NoCategoryException>()));

      expect(() => bmiCalculator.getCategory(-28),
          throwsA(isInstanceOf<NoCategoryException>()));
    });
  });
}
