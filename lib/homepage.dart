// import 'package:Result8/api/api.dart';

import 'package:Result8/api/api.dart';
import 'package:Result8/result.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String symbol_number = "";
  String dob ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(0, 113, 188, 0.9),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:30.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/Icon.png",
                  ),
                  radius: 50,
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      textAlign: TextAlign.center,
                      // keyboardType: TextInputType.\number,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          hintText: "Symbol Number"),
                      validator: ((val) {
                        return val.isEmpty ? "Enter Symbol Number" : null;
                      }),
                      onChanged: (val) {
                        setState(() {
                          symbol_number = val;
                        });
                      },
                    ),SizedBox(height: 10),
                    TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    hintText: "Date Of Birth : YYYY-MM-DD"),
                validator: ((val) {
                  return val.length !=10 ? "2076-05-06 use this as reference" : null;
                }),
                onChanged: (val) {
                  setState(() {
                    dob = val;
                  });
                },
              ),
                  ],
                ),
              ),
              
              
              SizedBox(height: 25.0),
              RaisedButton(
                  elevation: 12.0,
                  color: Color.fromRGBO(52, 152, 249, 1),
                  // splashColor: Colors.blue[50],
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 21),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Text(
                    "Submit".toUpperCase(),
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      dynamic u = await Apiresult().getresult(symbol_number,dob);
                      print(
                          "ssssssssssssssssssssssssssssssssssssssssssssssssss");
                      print(u);
                      if (u != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(student: u)));
                      }
                      if (u == null) {
                        print("ghhkjhxcvhkuhdfcgvhjig");
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "There seems to be an issue with your network or you have entered wrong credentials"),
                          ),
                        );
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
