
import 'package:lab3/widgets/calculator_button.dart';
import 'package:lab3/widgets/history_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab3/constants/app_constants.dart';


void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  CalculatorAppState createState() => CalculatorAppState();
}

//aplicatia calculeaza suma, diferenta, catul si produsul dintre doua numere
//sunt definite doar operatii dintre 2 numere

class CalculatorAppState extends State<CalculatorApp> {

  int firstNum = 0;
  int secondNum = 0;
  //
  String history = '';
  //textul pentru a fi afisat cand se apasa pe un buton
  String textToDisplay = '';
  //rezultatul
  String res = '';
  //operatia
  String operation = '';
  //toata istoria, momentan aplicatia e mica si e de test, se pastreaza doar intr-o variabila, nu in context nu extern
  static String historyBig = '';

  //functie ce compune forma expresiei aritmetice pentru istorie
  void writeHistory() {
    history = firstNum.toString() + operation.toString() + secondNum.toString();
  }

  //functie ce compune forma expresiei partial fara al doilea numar
  void writePartialHistory() {
    history = firstNum.toString() + operation.toString();
  }

  //rol de declansator pentru eveniment de apasare pe orice buton
  void btnOnClick(String btnVal) {
    //C sterge doar operatia curenta
    if (btnVal == 'C') {
      textToDisplay = '';
      firstNum = 0;
      secondNum = 0;
      res = '';
      //sterge si istoria la operatia
    } else if (btnVal == 'AC') {
      textToDisplay = '';
      firstNum = 0;
      secondNum = 0;
      res = '';
      history = '';
      //cand se schimba din plus in minus
    } else if (btnVal == '+/-') {
      if (textToDisplay[0] != '-') {
        res = '-$textToDisplay';
      } else {
        res = textToDisplay.substring(1);
      }
      //sterge din expresie ultima cifra
    } else if (btnVal == '<') {
      res = textToDisplay.substring(0, textToDisplay.length - 1);
      //daca e un operator aritmetic
    } else if ( btnVal == '+' || btnVal == '-' || btnVal == 'X' || btnVal == '/') {
      //transforma in numar
      firstNum = int.parse(textToDisplay);
      res = '';
      operation = btnVal;
      writePartialHistory();
      //in functie de operator efectueaza operatia necesara dintre 2 numere
    } else if (btnVal == '=') {
      secondNum = int.parse(textToDisplay);
      if (operation == '+') {
        res = (firstNum + secondNum).toString();
        writeHistory();
      }
      if (operation == '-') {
        res = (firstNum - secondNum).toString();
        writeHistory();
      }
      if (operation == 'X') {
        res = (firstNum * secondNum).toString();
        writeHistory();
      }
      if (operation == '/') {
        res = (firstNum / secondNum).toString();
        writeHistory();
      }
      historyBig += "\n";
      historyBig += history.toString();
      historyBig += "\n";
      historyBig += "=" + res.toString();
    } else {
      res = int.parse(textToDisplay + btnVal).toString();
    }

    //set state in state permite schimbarea starii obiectelor, de exemplu schimbarea culorii, textului etc
    setState(() {
      textToDisplay = res;
    });
  }
  @override
  /* @override subliniază că funcția este definită și într-o clasă părinte, dar este redefinită pentru a face altceva în
     clasa curentă. De asemenea, este folosit pentru a adnota implementarea unei metode abstracte
     Recomandat deoarece îmbunătățește lizibilitatea (care poate fi citit cu ușurință) */

  Widget build(BuildContext context) {
    /* Pentru a crea orice widget, se folosește metoda build(), care acceptă BuildContext ca argument.
     BuildContext este o descriere a poziției widgetului și permite implementarea unor funcții */
    return MaterialApp(
      /* MaterialApp - clasă predefinită în flutter. Putem accesa toate celelalte componente și widget-uri furnizate de Flutter SDK.
       text, dropdownbutton, Scaffold, ListView, IconButton, TextField, Padding, ThemeData
       sunt widget-urile care pot fi accesate folosind clasa MaterialApp */
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Scaffold(
        //culoare de fundal
        backgroundColor: Color(0xFFF5F5FF),
        body: Column(
        children: <Widget> [
          Expanded(child:
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(80),
                    child: Text(
                      'Calculator',
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF252C32),
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ),
          historyButton(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                currentOperationHistory(),
                currentOperation(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorButton(text: 'AC',
                  fillColor: primary,
                  textColor: danger,
                  textSize: 28,
                  callback: btnOnClick,
                  ),
                  CalculatorButton(text: 'C',
                    fillColor: primary,
                    textColor: danger,
                    textSize: 28,
                    callback: btnOnClick,
                  ),
                  CalculatorButton(text: '<',
                    fillColor: primary,
                    textColor: secondary,
                    textSize: 28,
                    callback: btnOnClick,
                  ),
                  CalculatorButton(text: '/',
                    fillColor: primary,
                    textColor: secondary,
                    textSize: 28,
                    callback: btnOnClick,
                  ),
                ],
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '7',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '8',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '9',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: 'X',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '4',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '5',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '6',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '-',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '1',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '2',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '3',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '+',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton(text: '+/-',
                      fillColor: primary,
                      textColor: secondary,
                      textSize: 22,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '0',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '00',
                      fillColor: primary,
                      textColor: info,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                    CalculatorButton(text: '=',
                      fillColor: secondary,
                      textColor: primary,
                      textSize: 28,
                      callback: btnOnClick,
                    ),
                  ],
                ),
              ],
            )
          )
        ]
        )
      )
    );
  }

  Container currentOperation() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          textToDisplay,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
                fontSize: 48,
                color: Colors.black
            ),
          ),
        ),
      ),
      alignment: Alignment(1.0, 1.0),
    );
  }

  Container currentOperationHistory() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(right: 12),
        child: Text(
          history,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              fontSize: 24,
              color: info,
            ),
          ),
        ),
      ),
      alignment: Alignment(1.0, 1.0),
    );
  }

  Container historyButton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 40,
        height: 40,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll<Color>(primary),
          ),
          child: Icon(
            Icons.access_time_outlined,
            color: secondary,
          ),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => HistoryPage(history: historyBig)),
            );
          },
        ),
      ),
    );
  }
}
