import 'package:bmi_calc/bloc/bmi_bloc.dart';
import 'package:bmi_calc/errors/errors.dart';
import 'package:bmi_calc/screens/result_screen.dart';
import 'package:bmi_calc/units.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocListener<BmiBloc, BmiState>(
            listener: (context, state) {
              if (state is BmiError) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            child: BlocBuilder<BmiBloc, BmiState>(
              buildWhen: (previous, current) {
                if (current is BmiError) {
                  return false;
                } else
                  return true;
              },
              builder: (context, state) {
                if (state is BmiInitial) {
                  return _buildHomePage(state.unitSelected);
                } else if (state is BmiShowResults) {
                  return _buildHomePage(state.unitSelected);
                } else
                  throw NoStateException();
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _buildHomePage(Units unit) {
    return Column(
      children: [
        Text(
          'Wzrost',
          style: TextStyle(fontSize: 20.0),
        ),
        TextField(
          controller: heightController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Podaj wzrost',
            suffixText: unit == Units.metric
                ? unitsSufix[UnitsSuffix.metricHeight]
                : unitsSufix[UnitsSuffix.imperialHeight],
          ),
        ),
        SizedBox(height: 50.0),
        Text(
          'Waga',
          style: TextStyle(fontSize: 20.0),
        ),
        TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Podaj wagę',
            suffixText: unit == Units.metric
                ? unitsSufix[UnitsSuffix.metricWeight]
                : unitsSufix[UnitsSuffix.imperialWeight],
          ),
        ),
        SizedBox(height: 50.0),
        _buildDropdownButton(unit),
        SizedBox(height: 50.0),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20.0))),
          onPressed: () {
            BlocProvider.of<BmiBloc>(context).add(
              GetBmiResults(
                  weightController.value.text, heightController.value.text),
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<BmiBloc>(context),
                  child: ResultScreen(),
                ),
              ),
            );
          },
          child: Text('Calculate BMI!'),
        ),
      ],
    );
  }

  DropdownButton _buildDropdownButton(Units unit) {
    return DropdownButton<Units>(
      value: unit,
      onChanged: (value) {
        BlocProvider.of<BmiBloc>(context).add(DropdownChange(value!));
      },
      items: Units.values.map((e) {
        return DropdownMenuItem<Units>(
          value: e,
          child: Text(_returnUnitName(e)),
        );
      }).toList(),
    );
  }

  String _returnUnitName(Units unit) {
    if (unit == Units.metric) {
      return 'metryczne';
    } else if (unit == Units.imperial) {
      return 'imperialne';
    } else {
      throw NoUnitException();
    }
  }
}
