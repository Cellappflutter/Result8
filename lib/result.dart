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
        title: Text("RESULT"),
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
                                "${widget.student.student.firstname.toString()} ${widget.student.student.lastname.toString()}",
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
                      text: TextSpan(text: "Symbol No.: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) ,children: <TextSpan>[
                        TextSpan(
                            text:
                                "${widget.student.student.symbol_no.toString()}",
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
                                " ${widget.student.student.school_name.toString()}",
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
                                " ${widget.student.student.school_id.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                    
                     RichText(
                      text: TextSpan(text: "Year: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) ,children: <TextSpan>[
                        TextSpan(
                            text:
                                " ${widget.student.student.year.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                      ]),
                    ),
                    
                     RichText(
                      text: TextSpan(text: "Regd No.: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) ,children: <TextSpan>[
                        TextSpan(
                            text:
                                " ${widget.student.student.reg_id.toString()}",
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
                            DataCell(Text(e.name.toString())),
                            DataCell(Text(e.credit.toString())),
                            DataCell(Text(e.grade.toString())),
                            DataCell(Text(e.gpa.toString()))
                          ]))
                      .toList()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                        text: TextSpan(text: "Average GPA: ", style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black) ,children: <TextSpan>[
                          TextSpan(
                              text:
                                  " ${widget.student.avggpa.toString()}",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
                        ]),
                    ),
                      ),
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
