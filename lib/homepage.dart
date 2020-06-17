import 'dart:async';

import 'package:Result8/api/api.dart';
import 'package:Result8/bloc/network_bloc.dart';
import 'package:Result8/model/model.dart';
import 'package:Result8/result.dart';
import 'package:Result8/widgets/button.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/sms.dart';

class HomePage extends StatefulWidget {
  final bool isshow;

  const HomePage({Key key,@required this.isshow}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SmsSender sender = new SmsSender();
  final SmsReceiver receiver = new SmsReceiver();
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final symbol_number = TextEditingController();
  final dob = TextEditingController();

 // bool show = widget.isshow;
  var _connectionStatus = "unknown";
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    symbol_number.clear();
    dob.clear();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        BlocProvider.of<NetworkBloc>(context).add(Connected());
      } else if (result == ConnectivityResult.none) {
        BlocProvider.of<NetworkBloc>(context)..add(Disconnected());
      }
    });
  }

  @override
  void dispose() {
    dob.dispose();
    symbol_number.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkInitial) {
         _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        "You have disconnected from the internet go back to use the SMS service"),
                                  ),
                                );
        } else if (state is NetworkConected) {
          
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
                          controller: symbol_number,
                          textAlign: TextAlign.center,
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
                          // onChanged: (val) {
                          //   setState(() {
                          //     symbol_number = val;
                          //   });
                          // },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: dob,
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
                         
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  widget.isshow
                      ? 
                      CellButton(
                text: "Submit",
                onpressed: ()   async {
                            if (_formkey.currentState.validate()) {
                              Studentdata u = await Apiresult()
                                  .getresult(symbol_number.text, dob.text);
                              print(symbol_number.text);
                              print(dob.text);
                              if (u.status == true) {
                                symbol_number.clear();
                                dob.clear();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyHomePage(student: u)));
                              }
                              if (u.status == false) {
                               
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        u.message.toString()),
                                  ),
                                );
                              }
                            }
                          },
              )
                      : CellButton(text: 'Message', onpressed: ()async {
                            if (_formkey.currentState.validate()) {
                              _sendingSMS("35001", "rslt <${symbol_number.text}>");
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
