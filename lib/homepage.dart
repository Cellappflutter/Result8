// import 'package:Result8/api/api.dart';

import 'dart:async';

import 'package:Result8/api/api.dart';
import 'package:Result8/bloc/network_bloc.dart';
import 'package:Result8/result.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/sms.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SmsSender sender = new SmsSender();
  final SmsReceiver receiver = new SmsReceiver();
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String symbol_number = "";
  String dob = "";
  bool show = false;
  var _connectionStatus = "unknown";
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print(result);
        BlocProvider.of<NetworkBloc>(context).add(Connected());
      } else if (result == ConnectivityResult.none) {
        print(result);
        BlocProvider.of<NetworkBloc>(context)..add(Disconnected());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkInitial) {
          print("soansdfasd fasd ");
          setState(() {
            show = false;
          });
        } else if (state is NetworkConected) {
          print("daasdfasdfasdfasdfasd");
          setState(() {
            show = true;
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(0, 112, 184, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Icon.png")),
                          ))),
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
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
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
                              hintText: "Date Of Birth : YYYY-MM-DD"),
                          validator: ((val) {
                            return val.length != 10
                                ? "2076-05-06 use this as reference"
                                : null;
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
                  show ? RaisedButton(
                      elevation: 12.0,
                      color: Color.fromRGBO(52, 152, 249, 1),
                      // splashColor: Colors.blue[50],
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 21),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: Text(
                        "Submit".toUpperCase(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          dynamic u =
                              await Apiresult().getresult(symbol_number, dob);

                          if (u != null) {
                            setState(() {
                              symbol_number = "";
                              dob = "";
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyHomePage(student: u)));
                          }
                          if (u == null) {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    "There seems to be an issue with your network or you have entered wrong credentials"),
                              ),
                            );
                          }
                        }
                      }):
                  
                   RaisedButton(
                          elevation: 12.0,
                          color: Color.fromRGBO(52, 152, 249, 1),
                          // splashColor: Colors.blue[50],
                          textColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 21),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          child: Text(
                            "Message".toUpperCase(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                            _sendingSMS("9841048006", symbol_number);
                            }
                          })
                      
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   Future _sendingSMS(String reception, String msg) async {
    SmsMessage message = SmsMessage(reception, msg);
    message.onStateChanged.listen((event) {
      if (event == SmsMessageState.Sent) {
        print("SMS Sent!");
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Color.fromRGBO(0, 113, 188, 0.9),
            content: Text("SMS Sent !")));
      } else if (event == SmsMessageState.Sending) {
        print("SMS Sending...");
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Color.fromRGBO(0, 113, 188, 0.9),
            content: Text("SMS Sending...")));
      } else if (event == SmsMessageState.Delivered) {
        print("SMS is delivered");
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Color.fromRGBO(0, 113, 188, 0.9),
            content: Text("SMS Delivered !")));
      }
    });
    try {
      sender.sendSms(message);
    } catch (e) {
      print(e);
    }
    receiver.onSmsReceived.listen((SmsMessage message) => print(message.body));
  }
}
