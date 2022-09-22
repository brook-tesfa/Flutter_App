import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/components/User.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../complete_profile/components/complete_profile_form.dart';
import '../../login_success/login_success_screen.dart';
import '../../otp/otp_screen.dart';
import '../../sign_in/components/sign_form.dart';
import '../../sign_in/sign_in_screen.dart';
import '../profile_screen.dart';

class AnotherValid extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<AnotherValid> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  String? firstName;
  String? lastName;
  String? age;
  String? gender;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController passwordd = TextEditingController();
  // TextEditingController _ageController = TextEditingController();
  // TextEditingController _genderCntroller = TextEditingController();
  bool _isloading = false;

  Update(
      String fname, String lname, String email, String age, String pass) async {
    var url = Uri.parse("http://localhost:3000/api/editProfile");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "email": email,
      "password": pass,
      "firstName": fname,
      "lastName": lname,
      "age": age,
    };
    var token = sharedPreferences.getString("token");
    var jsonResponse;
    var res = await http.post(url,
        headers: {'Authorization': 'Bearer ' + token.toString() + ''},
        body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      if (jsonResponse != null) {
        setState(() {
          _isloading = false;
        });
      } else {
        setState(() {
          _isloading = false;
        });
        print('Response body: ${res.body}');
      }
    } else {
      print(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final post_ = ModalRoute.of(context)!.settings.arguments as User;
    // var firstname = TextEditingController();
    firstname.text = post_.firstName.toString();
    //var lastname = TextEditingController();
    lastname.text = post_.lastName.toString();
    // var Email = TextEditingController();
    // Email.text = post_.email.toString();
    // var Age = TextEditingController();
    Age.text = post_.age.toString();
    // var password = TextEditingController();
    passwordd.text = post_.password.toString();
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              buildEmailFormField(Email),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(passwordd),
              SizedBox(height: getProportionateScreenHeight(30)),
              //  buildConformPassFormField(),
              //  SizedBox(height: getProportionateScreenHeight(30)),
              buildFirstNameFormField(firstname),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildLastNameFormField(lastname),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPhoneNumberFormField(Age),
              SizedBox(height: getProportionateScreenHeight(30)),
              // buildAddressFormField(),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "Continue",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // if all are valid then go to success screen;
                    // Navigator.pushNamed(context, HomeScreen.routeName);
                    await Update(firstname.text, lastname.text, Email.text,
                        Age.text, passwordd.text);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProfileScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
                onPressed: firstname.text == "" ||
                        lastname.text == "" ||
                        Email.text == "" ||
                        Age.text == "" ||
                        passwordd.text == ""
                    ? null
                    : () {
                        setState(() {
                          _isloading = true;
                        });
                      },
              ),
            ],
          ),
        ));
  }

  // TextFormField buildAddressFormField() {
  //   return TextFormField(
  //     onSaved: (newValue) => gender = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kAddressNullError);
  //       }
  //       return null;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kAddressNullError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     controller: _genderCntroller,
  //     decoration: InputDecoration(
  //       labelText: "Gender",
  //       hintText: "Enter your Gender",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon:
  //           CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
  //     ),
  //   );
  // }

  TextFormField buildPhoneNumberFormField(Age) {
    final post_ = ModalRoute.of(context)!.settings.arguments as User;
    // var Age = TextEditingController();
    // Age.text = post_.age.toString();
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => age = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      controller: Age,
      decoration: InputDecoration(
        labelText: "Age",
        hintText: "Enter your Age",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField(lastname) {
    final post_ = ModalRoute.of(context)!.settings.arguments as User;
    // var lastname = TextEditingController();
    // lastname.text = post_.lastName.toString();
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      controller: lastname,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField(firstname) {
    final post_ = ModalRoute.of(context)!.settings.arguments as User;
    // var firstname = TextEditingController();
    // firstname.text = post_.firstName.toString();
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      controller: firstname,
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  // TextFormField buildConformPassFormField() {
  //   return TextFormField(
  //     obscureText: true,
  //     onSaved: (newValue) => conform_password = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kPassNullError);
  //       } else if (value.isNotEmpty && password == conform_password) {
  //         removeError(error: kMatchPassError);
  //       }
  //       conform_password = value;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kPassNullError);
  //         return "";
  //       } else if ((password != value)) {
  //         addError(error: kMatchPassError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     controller: _RepassController,
  //     decoration: InputDecoration(
  //       labelText: "Confirm Password",
  //       hintText: "Re-enter your password",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
  //     ),
  //   );
  // }

  TextFormField buildPasswordFormField(passwordd) {
    final post_ = ModalRoute.of(context)!.settings.arguments as User;
    // var passwordd = TextEditingController();
    // passwordd.text = post_.password.toString();
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      controller: passwordd,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(Email) {
    final post_ = ModalRoute.of(context)!.settings.arguments as User;
    // var Email = TextEditingController();
    // Email.text = post_.email.toString();
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      controller: Email,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
