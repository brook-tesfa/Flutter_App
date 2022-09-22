import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/screens/home/components/post.dart';
import 'package:shop_app/screens/profile/components/Update_Screen.dart';
import 'package:shop_app/screens/profile/components/User.dart';
import 'package:shop_app/screens/profile/components/another_validator.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final post_ = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.green,
        //   ),
        //   onPressed: () {},
        // ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.settings,
        //       color: Colors.green,
        //     ),
        //     onPressed: () {
        //       // Navigator.of(context).push(MaterialPageRoute(
        //       //     builder: (BuildContext context) => SettingsPage()));
        //     },
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              // Text(
              //   "Profile",
              //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              // ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/person-icon.png",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                " Name : " +
                    "  " +
                    post_.firstName.toString() +
                    " " +
                    post_.lastName.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Email  : " + "  " + post_.email.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Password  : " + "  " + post_.password.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              // buildTextField("Full Name", "Dor Alex", false),
              // buildTextField("E-mail", "alexd@gmail.com", false),
              // buildTextField("Password", "********", true),
              // buildTextField("Location", "TLV, Israel", false),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 50),
                  //   child: OutlinedButton(
                  //     // shape: RoundedRectangleBorder(
                  //     //     borderRadius: BorderRadius.circular(20)),
                  //     onPressed: () {},
                  //     child: Text("CANCEL",
                  //         style: TextStyle(
                  //             fontSize: 14,
                  //             letterSpacing: 2.2,
                  //             color: Colors.black)),
                  //   ),
                  // ),
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => AnotherValid(),
                                settings: RouteSettings(arguments: post_)));
                      },
                      color: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    var showPassword;
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
    //    Widget getListView() {
    // var listView = ListView(
    //   children: <Widget>[
    //     ListTile(
    //       title: Text(post_.firstName.toString()),
    //     )
    //   ],
    // );
    // return listView;
 