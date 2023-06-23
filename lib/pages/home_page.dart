import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_calculation/pages/calculate_result.dart';
import 'package:test_calculation/pages/calculation.dart';
import 'package:test_calculation/pages/widget/button_widget.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BuildBodyHomePage(),
      ),
    );
  }
}

class BuildBodyHomePage extends StatefulWidget {
  BuildBodyHomePage({Key? key}) : super(key: key);

  @override
  _BuildBodyHomePageState createState() => _BuildBodyHomePageState();
}

class _BuildBodyHomePageState extends State<BuildBodyHomePage> with SingleTickerProviderStateMixin {
  double principal = Calculation().principal;
  double rate = Calculation().rate;
  double time = Calculation().time;
  double interest = Calculation().interest;
  double principalWithInterest = Calculation().principalWithInterest;
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Principal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    principal = double.tryParse(value) ?? 0;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Rate of Interest (%)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    rate = double.tryParse(value) ?? 0;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Time (in years)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    time = double.tryParse(value) ?? 0;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ButtonWidget(
                    text: 'Calculate',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        interest = (principal * rate * time) / 100;
                        interest = double.parse(interest.toStringAsFixed(2));
                        principalWithInterest = principal + interest;
                        principalWithInterest = double.parse(principalWithInterest.toStringAsFixed(2));
                        setState(() {
                          showResult = true;
                        });

                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  ButtonWidget(
                    text: 'Reset',
                    onPressed: () {
                      setState(() {
                        _formKey.currentState!.reset();
                        principal = 0;
                        rate = 0;
                        time = 0;
                        showResult = false;
                        interest = 0;
                        principalWithInterest = 0;
                      });
                    },
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              if (showResult)
                CalculatorResultWidget(
                  result: 'Interest\n $interest\n\nTotal Amount\n $principalWithInterest',
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
