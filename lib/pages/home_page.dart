import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_calculation/pages/calculate_result.dart';
import 'package:test_calculation/pages/widget/button_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  double principal = 0;
  double rate = 0;
  double time = 0;
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;
  double interest = 0;
  double principalWithInterest = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
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
      ),
    );
  }
}
