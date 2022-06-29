// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, use_key_in_widget_constructors, must_be_immutable, unnecessary_this

import 'package:flutter/material.dart';
import 'package:simple_interest_calculator/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];

  final double _minimumPadding = 5.0;

  var selecteditems = 'Rupees';

  TextEditingController principalcontrolled = TextEditingController();

  TextEditingController roicontrolled = TextEditingController();

  TextEditingController termcontrolled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SI Calculator"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            // margin: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Image.asset(
                  "images/SI.png",
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: principalcontrolled,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter principal amount';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Principal e.g 12000",
                        labelText: "Principal",
                        // labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: roicontrolled,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Rate of interest",
                          hintText: "Enter interest in % e.g 5",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: termcontrolled,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter time';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Time",
                              hintText: "Time in years",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: selecteditems,
                          onChanged: (String? newValueSelected) {
                            onDropDownItemSelected(newValueSelected!);
                            //your code
                          },
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Text(
                              "Calculate",
                              textScaleFactor: 1.1,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formkey.currentState!.validate()) {
                                  this.displayResult = _CalculateTotalReturns();
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text(
                              "Reset",
                              textScaleFactor: 1.1,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        displayResult,
                        textScaleFactor: 1.1,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
      drawer: MyDrawer(),
    );
  }

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.selecteditems = newValueSelected;
    });
  }

  String _CalculateTotalReturns() {
    double principal = double.parse(principalcontrolled.text);
    double roi = double.parse(roicontrolled.text);
    double term = double.parse(termcontrolled.text);

    double SimpleInterest = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $SimpleInterest $selecteditems';
    return result;
  }

  void _reset() {
    principalcontrolled.text = '';
    roicontrolled.text = '';
    termcontrolled.text = '';
    displayResult = '';
    selecteditems = _currencies[0];
  }
}
