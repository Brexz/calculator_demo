import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String eq = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize =  48.0;






  buttonPressed(String buttonText) {
    setState(() {
      if(buttonText=="C") {
        eq = "0";
        result = "0";
      } else if(buttonText=="⌫"){
        eq = eq.substring(0, eq.length-1);
        if (eq=="") {
          eq = "0";
        }
      } else if(buttonText=="=") {
        
        expression = eq;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result="error";
        }

      } else {
        if (eq == "0") {
            eq = buttonText;
        } else {
          eq = eq + buttonText;
        }
      }
    });

  }

  Widget buildButton (String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height*0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid
            )
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText, style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white
        ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(eq, style: TextStyle(fontSize: equationFontSize),),
            ),

            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(result, style: TextStyle(fontSize: resultFontSize),),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*.75,
                  child: Table(
                    children: [
                      TableRow(
                          children: [
                            buildButton("C", 1, Colors.grey),
                            buildButton("⌫", 1, Colors.lightBlue),
                            buildButton("÷", 1, Colors.lightBlue)
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("7", 1, Colors.lightGreen),
                            buildButton("8", 1, Colors.lightGreen),
                            buildButton("9", 1, Colors.lightGreen)
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("4", 1, Colors.lightGreen),
                            buildButton("5", 1, Colors.lightGreen),
                            buildButton("6", 1, Colors.lightGreen)
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("1", 1, Colors.lightGreen),
                            buildButton("2", 1, Colors.lightGreen),
                            buildButton("3", 1, Colors.lightGreen)
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton(".", 1, Colors.lightGreen),
                            buildButton("0", 1, Colors.lightGreen),
                            buildButton("00", 1, Colors.lightGreen)
                          ]
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width* 0.25,
                  child: Table(
                    children: [
                      TableRow(
                          children: [
                            buildButton("×", 1, Colors.lightBlue),
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("-", 1, Colors.lightBlue),
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("+", 1, Colors.lightBlue),
                          ]
                      ),
                      TableRow(
                          children: [
                            buildButton("=", 2, Colors.lightBlue),
                          ]
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]
      ),
    );
  }
}
