// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_types_as_parameter_names, non_constant_identifier_names, file_names, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_switch/sliding_switch.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  ThemeData currentTheme = ThemeData.light();
  String _expression = '';
  String _result = '';
  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '=') {
        try {
          _result = evaluateExpression(_expression).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else if (buttonText == 'B') {
        // Handle backspace
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (isOperator(buttonText)) {
        _expression += ' $buttonText ';
      } else {
        _expression += buttonText;
      }
    });
  }

  bool isOperator(String buttonText) {
    return ['+', '-', '*', '/', '%'].contains(buttonText);
  }

  double evaluateExpression(String expression) {
    List<String> parts = expression.split(' ');

    parts = parts.where((part) => part.isNotEmpty).toList();

    double result = double.parse(parts[0]);

    for (int i = 1; i < parts.length; i += 2) {
      String operator = parts[i];
      double operand = double.parse(parts[i + 1]);

      // Perform the operation
      if (operator == '+') {
        result += operand;
      } else if (operator == '-') {
        result -= operand;
      } else if (operator == '*') {
        result *= operand;
      } else if (operator == '/') {
        result /= operand;
      } else if (operator == '%') {
        result %= operand;
      }
    }

    return result;
  }

  bool isSwitched = false;
  bool isDark = false;
  ThemeData lightThemeData(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
    );
  }

  ThemeData darkThemeData(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.tealAccent,
      scaffoldBackgroundColor: Colors.grey[850],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: isDark ? darkThemeData(context) : lightThemeData(context),
            home: WillPopScope(
              onWillPop: () => _onWillPop(context),
              child: Scaffold(
                body: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5.h, 70.w, 0),
                      child: SlidingSwitch(
                        width: 32.w,
                        height: 6.h,
                        value: isDark,
                        onChanged: (value) {
                          setState(() {
                            isDark = value;
                          });
                        },
                        animationDuration: const Duration(milliseconds: 400),
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        textOff: "light",
                        textOn: "dark",
                        iconOff: Icons.light_mode,
                        iconOn: Icons.dark_mode,
                        contentSize: 14,
                        colorOn: const Color(0xffdc6c73),
                        colorOff: const Color(0xff6682c0),
                        background: const Color(0xffe4e5eb),
                        buttonColor: const Color(0xfff7f5f7),
                        inactiveColor: const Color(0xff636f7b),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.w, 3.h, 5.w, 0.h),
                      child: Container(
                          height: 24.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes the shadow position
                              ),
                            ],
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SafeArea(
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(9, 1.0.h, 0, 5.h),
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '$_expression    ',
                                      style: TextStyle(fontSize: 24.0),
                                    ),
                                  ),
                                ),
                              ),
                              SafeArea(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(9, 1.0.h, 0, 0),
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '$_result    ',
                                    style: TextStyle(fontSize: 24.0),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.h, 0, 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: _Button('C')),
                          Expanded(child: _Button('B')),
                          Expanded(child: _Button('.')),
                          Expanded(child: _Button1('/')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.h, 0, 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: _Button('7')),
                          Expanded(child: _Button('8')),
                          Expanded(child: _Button('9')),
                          Expanded(child: _Button1('*')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.h, 0, 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: _Button('4')),
                          Expanded(child: _Button('5')),
                          Expanded(child: _Button('6')),
                          Expanded(child: _Button1('+')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.h, 0, 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: _Button('1')),
                          Expanded(child: _Button('2')),
                          Expanded(child: _Button('3')),
                          Expanded(
                            child: _Button1('-'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0.h, 0, 2.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: _Button2('00')),
                          Expanded(child: _Button('0')),
                          Expanded(child: _Button1('=')),
                          Expanded(child: _Button1('%')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _Button(String button) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 0),
          child: Container(
            width: 17.w,
            height: 8.h,
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.blueAccent,
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(44.0),
              child: ElevatedButton(
                onPressed: () {
                  _onButtonPressed(button);
                },
                // ignore: sort_child_properties_last
                child: Text(
                  button,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        // When pressed
                        return Colors.black87
                            .withOpacity(0.5); // Change to desired color
                      }
                      // Default color
                      return Colors.white;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _Button1(String button) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 0),
          child: Container(
            width: 17.w,
            height: 8.h,
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.blueAccent,
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(44.0),
              child: ElevatedButton(
                onPressed: () {
                  _onButtonPressed(button);
                },
                // ignore: sort_child_properties_last
                child: Text(
                  button,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        // When pressed
                        return Colors.black87
                            .withOpacity(0.5); // Change to desired color
                      }
                      // Default color
                      return Colors.transparent;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _Button2(String button) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 0),
          child: Container(
            width: 18.w,
            height: 8.h,
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.blueAccent,
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(44.0),
              child: ElevatedButton(
                onPressed: () {
                  _onButtonPressed(button);
                },

                // ignore: sort_child_properties_last
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        // When pressed
                        return Colors.black87
                            .withOpacity(0.5); // Change to desired color
                      }
                      // Default color
                      return Colors.white;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want to exit the application?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
