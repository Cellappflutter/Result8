import 'dart:convert';
import 'dart:io';

import 'package:Result8/model/model.dart';
import 'package:http/http.dart';

class Apiresult{
String baseurl = "https://grade8.smartpalika.org/api/get-result";
  Future<Akodata> getresult(String symbol_no, dob) async {
    Response response = await post(baseurl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
        },
        body: jsonEncode({'symbol_no': symbol_no, 'dob': dob}));

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      print("fasdfasdfasdfasdfasd");
      print(body);
      Akodata posts =Akodata.fromJson(body);
      print('length');
      print(posts.student.firstname);
      return posts;
    } else {
      
    }
  }
}