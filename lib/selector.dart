import 'package:Result8/homepage.dart';
import 'package:Result8/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class Selector extends StatelessWidget {
  final int id;
  const Selector({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 112, 184, 1),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 40,
          width: MediaQuery.of(context).size.width,
          child: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CellButton(
                    text: "Online बाट थाहपौन",
                    onpressed: () => Navigator.pushNamed(context, 'homepage',arguments: true),
                  ),
                  CellButton(
                    text: "SMS बाट थाहपौन",
                    onpressed: () => Navigator.pushNamed(context, 'homepage',arguments: false),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
