import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/home/components/content.dart';
import 'package:shop_app/screens/home/components/post.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  _Search createState() => _Search();
}

class _Search extends State<Body> {
  final TextEditingController _controller = TextEditingController();

  List<post> _posts = [];
  viewprofile(String find) async {
    var url = Uri.parse('http://localhost:3000/api/searchDrug');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"key": find};
    var token = sharedPreferences.getString("token");
    var jasonResponse;
    var res = await http.post(url,
        headers: {'Authorization': 'Bearer ' + token.toString() + ''},
        body: body);
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
        return jasonResponse;
        //  return jasonResponse.map((data) => new post.fromJson(data)).toList();
        // _posts = post.fromJson(jasonResponse[0]);
      } else {
        print('Response body:${res.body}');
        List<post> _posts = [];
        return _posts;
      }
    } else {
      print("eror" + res.body);
      List<post> _posts = [];
      return _posts;
    }
    // print(_posts.length);

    //_posts;
  }

  late Future<List<post>> futureData;
  late String key = "";
  @override
  void initState() {
    super.initState();
    // futureData = viewprofile(key);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: Column(children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: this._controller,
                    autofocus: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search Your Drug Here ..')),
                getImmediateSuggestions: true,
                hideOnError: true,
                suggestionsCallback: (pattern) async {
                  print(pattern);
                  return await viewprofile(pattern);
                },
                itemBuilder: (context, itemData) {
                  Map<String, dynamic> data = new Map<String, dynamic>();
                  data = itemData as Map<String, dynamic>;
                  // post d = data as post;
                  // post? data = post.fromJson(pp);
                  // showDialog(context: context, builder: builder);
                  //   var user = suggestion;
                  return ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(data['Drugname'].toString()),
                    subtitle: Text(data['drugDescription'].toString()),
                    // title: Text(data['id'].toString()),
                    //subtitle: Text(itemData['symbol'].toString()),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  Map<String, dynamic> data = new Map<String, dynamic>();
                  data = suggestion as Map<String, dynamic>;
                  post pst = post.fromJson(data);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContenetPage(),
                      settings: RouteSettings(arguments: pst)));
                },
              )
            ])),
            // SizedBox(height: getProportionateScreenHeight(20)),
            // HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            // Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
