import 'package:bmi_calc/bloc/bmi_bloc.dart';
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            child: BlocBuilder<BmiBloc, BmiState>(
              builder: (context, state) {
                if (state is BmiInitial) {
                  return _buildHomePage();
                } else if (state is BmiSelectedMetric) {
                  return _buildHomePage();
                } else if (state is BmiSelectedImperial) {
                  return _buildHomePage();
                } else if (state is BmiError) {
                  return _buildHomePage();
                } else {
                  return _buildHomePage();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _buildHomePage() {
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
            suffixText:
                BlocProvider.of<BmiBloc>(context).currentUnit == 'metric'
                    ? unitsSufix['metricHeight']
                    : unitsSufix['imperialHeight'],
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
            suffixText:
                BlocProvider.of<BmiBloc>(context).currentUnit == 'metric'
                    ? unitsSufix['metricWeight']
                    : unitsSufix['imperialWeight'],
          ),
        ),
        SizedBox(height: 50.0),
        _buildDropdownButton(),
        SizedBox(height: 50.0),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20.0))),
          onPressed: () {
            BlocProvider.of<BmiBloc>(context).add(
              GetBmiResults(
                double.tryParse(weightController.value.text),
                double.tryParse(heightController.value.text),
              ),
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

  DropdownButton _buildDropdownButton() {
    return DropdownButton(
      value: BlocProvider.of<BmiBloc>(context).currentUnit,
      onChanged: (value) {
        BlocProvider.of<BmiBloc>(context).add(DropdownChange(value));
      },
      items: units.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e.toString()),
        );
      }).toList(),
    );
  }
}
