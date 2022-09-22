import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/home/components/post.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:http/http.dart' as http;

import 'content.dart';

class SearchField extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<SearchField> {
  post _posts = post();
  Future viewprofile() async {
    var url = Uri.parse('http://localhost:3000/api/searchDrug');
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

        _posts = post.fromJson(jasonResponse[0]);
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

  @override
  Widget build(BuildContext context) {
    return Container(
        
        child: Column(children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          TypeAheadField<post>(
            textFieldConfiguration: TextFieldConfiguration(
                autofocus: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'What are you looking for?')),
            suggestionsCallback: (pattern) async {
              return await viewprofile();
            },
            itemBuilder: (context, post? suggestion) {
              final user = suggestion;
              return ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(user!.drugname.toString()),

                // subtitle: Text('\$${suggestion["lastName"]}'),
              );
            },
            onSuggestionSelected: (suggestion) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ContenetPage()));
            },
          )
        ]));
  }
}
