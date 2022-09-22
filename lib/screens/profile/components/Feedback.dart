import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/default_button.dart';

class FeedBack extends StatefulWidget {
  // static String routeName;

  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController _feedController = TextEditingController();
  bool _isloading = false;
  signUp(String message) async {
    var url = Uri.parse("http://localhost:3000/api/postFeedback");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "message": message,
    };
    var jsonResponse;
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      if (jsonResponse != null) {
        setState(() {
          _isloading = false;
        });
        print("response" + jsonResponse[0]['token']);
        sharedPreferences.setString("token", jsonResponse[0]['token']);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("FeedBack Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Feed Back Here"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLines: 5,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Enter Your Feedback Here Please',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: DefaultButton(
                text: " Send ",
                press: () {
                  // Navigator.pushNamed(context, HomeScreen.routeName);
                  signUp(
                    _feedController.text,
                  );
                },
                onPressed: _feedController.text == ""
                    ? null
                    : () {
                        setState(() {
                          _isloading = true;
                        });
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
