import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Quiz dia dos Namorados'),
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

  String screen = "home";

  List<String> questions = [
    "Qual é o seu nome?",
    "Qual é o mês do seu aniversário?",
    "Quanto é 1 + 1?"
  ];

  List<List<String>> options = [
    [
      "Maria",
      "Bárbara",
      "Joana"
    ],
    [
      "Julho",
      "Dezembro",
      "Junho"
    ],
    [
      "432532",
      "2",
      "64346323"
    ],
  ];

  List<String> answers = ["Bárbara", "Julho", "2"];

  List<String> answer = ['', '', ''];

  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: showWidgets()
    ));
  }

  Widget showWidgets() {
    switch (screen) {
      case "home" :
        return homeWidget();
        break;
      case "q0" :
      case "q1" :
      case "q2" :
        return questionWidget();
        break;
      case "final" :
        return finalWidget();
        break;
    }
  }

  Widget homeWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Teste", style:TextStyle(fontSize:20)),
        Text("Você é a minha alma gêmea?", style:TextStyle(fontSize:20)),
        Padding(
          padding: EdgeInsets.symmetric(vertical:30)
        ),
        Image.asset(
          "assets/question.png",
          width:200
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical:30)
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text("Iniciar teste", style: TextStyle(color:Colors.white)),
          onPressed: () => setState( (){
            screen = "q0";
            })
        )
      ],
    );
  }

  Widget questionWidget() {
    int j = int.parse(screen.replaceAll('q',''));
    List<Widget> items = [
      Text(questions[j], style:TextStyle(fontSize:20))
      ];
      items.addAll(createOptions(j));
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: items
      );
  }

  Widget finalWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Resultado", style:TextStyle(fontSize:20)),
        Padding(padding: EdgeInsets.symmetric(vertical:10)),
        Text("É VOCÊ SIM!", style:TextStyle(fontSize:20)),
        Padding(padding: EdgeInsets.symmetric(vertical:10)),
        Image.asset(
            "assets/heart.png",
            width:200
        ),
        Padding(padding: EdgeInsets.symmetric(vertical:10)),
        Text("Feliz Dia dos Namorados!", style:TextStyle(fontSize:20)),
        Padding(padding: EdgeInsets.symmetric(vertical:10)),
        RaisedButton(
            color: Colors.blue,
            child: Text("Refazer teste", style: TextStyle(color:Colors.white)),
            onPressed: () => setState( (){
              screen = "home";
              error = false;
              answer = ['','',''];
            })
        )
      ],
    );
  }

  List<Widget> createOptions(int j) {
    List<Widget> optionButtons = [];
    for (int i = 0; i < options[j].length; i++){
      optionButtons.add(createOptionButton(i,j));
    }
    return optionButtons;
  }

  Widget createOptionButton(int i, int j) {
    return RadioListTile(
      activeColor: error ? Colors.red : Colors.black,
      value: options[j][i],
      title: Text(options[j][i], style:TextStyle(
        color: error ? Colors.red : Colors.black
      )),
      groupValue: answer[j],
      onChanged: (value) {
        answer[j] = value;
        if (answers[j] == answer[j]){
          setState(() {
            j++;
            error = false;
            screen = j >= questions.length ?
              "final":
              "q" + j.toString();
          });
        }else{
          setState(() {
            error = true;
            screen = "q" + j.toString();
          });
        }
      }
    );
  }

}
