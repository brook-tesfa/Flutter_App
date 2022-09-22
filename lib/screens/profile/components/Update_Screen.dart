import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/profile/components/User.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/profile/components/profile_edit.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

import '../../home/home_screen.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
    var firstname = TextEditingController();
    firstname.text = post_.firstName.toString();
    var lastname = TextEditingController();
    lastname.text = post_.lastName.toString();
    var Email = TextEditingController();
    Email.text = post_.email.toString();
    var Age = TextEditingController();
    Age.text = post_.age.toString();
    var password = TextEditingController();
    password.text = post_.password.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              TextField(
                controller: firstname,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
              ),
              Text("First Name"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              TextField(
                // controller: _controllerEmail,
                controller: lastname,

                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              Text("Last Name"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                // onSaved: (newValue) => email = newValue,
                // onChanged: (value) {
                //   if (value.isNotEmpty) {
                //     removeError(error: kEmailNullError);
                //   } else if (emailValidatorRegExp.hasMatch(value)) {
                //     removeError(error: kInvalidEmailError);
                //   }
                //   return null;
                // },
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     addError(error: kEmailNullError);
                //     return "";
                //   } else if (!emailValidatorRegExp.hasMatch(value)) {
                //     addError(error: kInvalidEmailError);
                //     return "";
                //   }
                //   return null;
                // },
                onTap: () {},
                controller: Email,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              Text("Email"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              TextField(
                controller: Age,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Age",
                ),
              ),
              Text("Age"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              TextField(
                controller: password,
                obscureText: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              Text("Password"),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
              color: Colors.amber,
              onPressed: () async {
                // if (_formKey.currentState!.validate()) {
                //   _formKey.currentState!.save();
                // }
                await Update(
                    firstname.text.toString(),
                    lastname.text.toString(),
                    Email.text.toString(),
                    Age.text,
                    password.text.toString());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfileScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Text(
                "Done",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
