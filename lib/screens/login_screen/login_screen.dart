import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_module/screens/login_screen/widget/country_picker.dart';
import 'package:flutter_otp_module/screens/login_screen/widget/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _contactEditingController = TextEditingController();
  var _dialCode = '';

  //Login click with contact number validation
  Future<void> clickOnLogin(BuildContext context) async {
    if (_contactEditingController.text.isEmpty) {
      showErrorDialog(context, 'Enter Mobile Number.');
    } else {
      final responseMessage = await Navigator.pushNamed(context, '/otpScreen',
          arguments: '$_dialCode${_contactEditingController.text}');
      if (responseMessage != null) {
        showErrorDialog(context, responseMessage as String);
      }
    }
  }

  //callback function of country picker
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  //Alert dialogue to show error and response
  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //build method for UI Representation
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                const Text(
                  'Phone OTP Verification\nAditya Raj(2020179001',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Image.asset(
                  'assets/images/registration.png',
                  height: screenHeight * 0.4,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  'Please Login To Continue',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.blue,
                          offset: Offset(0.0, 0.7), //(x,y)
                          blurRadius: 60.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          border: Border.all(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            CountryPicker(
                              callBackFunction: _callBackFunction,
                              headerText: 'Select Country',
                              headerBackgroundColor:
                                  Theme.of(context).primaryColor,
                              headerTextColor: Colors.red,
                            ),
                            SizedBox(
                              width: screenWidth * 0.01,
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Mobile Number',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 13.5),
                                ),
                                controller: _contactEditingController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(clickOnLogin),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
