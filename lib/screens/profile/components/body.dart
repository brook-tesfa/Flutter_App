import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/profile/components/Feedback.dart';
import 'package:shop_app/screens/profile/components/Help_center.dart';
import 'package:shop_app/screens/profile/components/User.dart';
import 'package:shop_app/screens/profile/components/profile_edit.dart';

import '../../home/components/post.dart';
import '../../sign_in/sign_in_screen.dart';
import '../../sign_up/sign_up_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  User _posts = User();
  Future viewprofile() async {
    var url = Uri.parse('http://localhost:3000/api/viewProfile');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Map body = {"key": "p"};
    var token = sharedPreferences.getString("token");
    var jasonResponse;
    var res = await http.get(
      url,
      headers: {'Authorization': 'Bearer ' + token.toString() + ''},
    );
    if (res.statusCode == 200) {
      jasonResponse = json.decode(res.body);
      print("value" + jasonResponse.toString());
      // return post.fromJson(jasonResponse);
      //for (var json in jsonResponse) {
      //  _posts.add(post.fromJson(json));
      //  }
      // }
      if (jasonResponse != null) {
        print('Response body:${res.body}');

        _posts = User.fromJson(jasonResponse[0]);
      } else {
        print('Response body:${res.body}');
      }
    } else {
      print("eror" + res.body);
    }
    // print(_posts.length);

    _posts;
  }

  late Future profile;
  @override
  void initState() {
    super.initState();
    profile = viewprofile();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => ProfileEdit(),
                      settings: RouteSettings(arguments: _posts)))
            },
          ),
          ProfileMenu(
            text: "FeedBack",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => FeedBack(),
                      settings: RouteSettings(arguments: _posts)));
            },
          ),
          // ProfileMenu(
          //   text: "",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "About",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => HelpCenter(),
                  ));
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

// ···

