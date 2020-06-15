import 'package:Result8/model/model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final Akodata student;
  MyHomePage({Key key, @required this.student}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.student.udata.runtimeType);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("result"),
        backgroundColor: Color.fromRGBO(9, 112, 184, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("LUMBINI SANSKRITIK NAGARPALIKA",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("Province NO.5",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("RUPANDEHI",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(text: "Name: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),children: <TextSpan>[
                        TextSpan(
                            text:
                                "${widget.student.student.firstname} ${widget.student.student.lastname}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                    RichText(
                      text: TextSpan(text: "Symbol No.: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) ,children: <TextSpan>[
                        TextSpan(
                            text:
                                "${widget.student.student.symbol_no}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                   
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     RichText(
                      text: TextSpan(text: "School Name: ",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) , children: <TextSpan>[
                        TextSpan(
                            text:
                                " ${widget.student.student.school_name}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                    
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     RichText(
                      text: TextSpan(text: "School ID.: ",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) , children: <TextSpan>[
                        TextSpan(
                            text:
                                " ${widget.student.student.school_id}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                    
                     RichText(
                      text: TextSpan(text: "Year: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) ,children: <TextSpan>[
                        TextSpan(
                            text:
                                " ${widget.student.student.year}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                    
                     RichText(
                      text: TextSpan(text: "Regd No.: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) ,children: <TextSpan>[
                        TextSpan(
                            text:
                                " ${widget.student.student.reg_id}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                    
                  ],
                ),
              ),
              DataTable(
                  columns: <DataColumn>[
                    DataColumn(label: Text("Subject")),
                    DataColumn(label: Text("Credit")),
                    DataColumn(label: Text("Grade")),
                    DataColumn(label: Text("GPA"))
                  ],
                  rows: widget.student.udata
                      .map((e) => DataRow(cells: [
                            DataCell(Text(e.name)),
                            DataCell(Text(e.credit)),
                            DataCell(Text(e.grade)),
                            DataCell(Text(e.gpa.toString()))
                          ]))
                      .toList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(9, 112, 184, 1),
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.home,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
