import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/home/components/Payment.dart';
import 'package:shop_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_app/screens/home/components/post.dart';
import 'package:shop_app/screens/home/components/search_field.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../cart/cart_screen.dart';
import '../home_screen.dart';
import 'PharmacyMap.dart';
import 'post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContenetPage extends StatefulWidget {
  static String routeName = "/home";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<ContenetPage> {
  @override
  Widget build(BuildContext context) {
    final post_ = ModalRoute.of(context)!.settings.arguments as post;
    return Scaffold(
        appBar: AppBar(
          title: Text(post_.drugname.toString()),
          actions: [],
        ),
        body: Container(
          // width: SizeConfig.screenWidth ,
          // decoration: BoxDecoration(
          //   color: kSecondaryColor.withOpacity(0.1),
          //   borderRadius: BorderRadius.circular(15),
          // ),
          height: 700,
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 40,
            shadowColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/d1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Drug Name :" + " " + post_.drugname.toString(),
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Expire Date :" + " " + post_.expDate.toString(),
                    style: TextStyle(fontSize: 20),
                    // textAlign: TextAlign.justify,
                    // overflow: TextOverflow.ellipsis,
                    //maxLines: 6,
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Price :" + " " + post_.price.toString(),
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Pharmacy Name :" +
                        " " +
                        post_.pharmacy!.pharmacyName.toString(),
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: DefaultButton(
                  text: " Go To Map",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => PharmacyMap(),
                            settings:
                                RouteSettings(arguments: post_.pharmacy)));
                    // Navigator.pushNamed(context, PharmacyMap);
                  },
                  // onPressed: null,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // Container(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: getProportionateScreenWidth(100)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         // SearchField(),
              //         Column(
              //           children: [
              //             IconBtnWithCounter(
              //               svgSrc: "assets/icons/Cart Icon.svg",
              //               press: () => Navigator.pushNamed(
              //                   context, CartScreen.routeName),
              //             ),
              //             Text("Add To Cart"),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ]),
          ),
        ));
  }
}
