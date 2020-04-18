import 'package:flutter/material.dart';
import 'qizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'start_Page.dart';
import 'package:provider/provider.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  // Use Provider to listen the number to get the no of scratch card in home page
//  int data = 1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        initialRoute: 'sc1',
        routes: {
          'sc1': (context) => StartPage(),
          'sc2': (context) => QuizPageBack(),
        },
      ),
    );
  }
}

class QuizPageBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizePage(),
        ),
      ),
    );
  }
}

class QuizePage extends StatefulWidget {
  @override
  _QuizePageState createState() => _QuizePageState();
}

class _QuizePageState extends State<QuizePage> {
  List<Icon> scoreKeeper = [];
  int score = 0;
  int lives = 4; // Remaining lives
  int couponCount = 0;
  List<Icon> liveKeeper = List<Icon>.generate(
      4,
      (i) => Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 30.0,
          ));

  void checkAnswer(bool userPickAnswer) {
    bool correctAnswer = quizBrain.getQuestionBankAnswer();
    setState(() {
      if (correctAnswer == userPickAnswer) {
        score++;
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        lives -= 1;
        liveKeeper.removeAt(lives);
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      quizBrain.nextQuestion();

      if (quizBrain.isFinished() == true || lives == 0) {
        print("score: $score");
        if (score >= 5 && score < 10) {
          couponCount = 1;
        } else if (score >= 10) {
          couponCount = 2;
        }
        print("Coupon Count: $couponCount");
        // Add here the provider in order to update the no of coupon count
        Provider.of<Data>(context, listen: false).changeData(couponCount);
        Alert(
            context: context,
            title: 'Finished',
            desc:
                'Final Score: $score \nYou\'ve reached the end of quiz \n ${couponCount > 0 ? 'You won $couponCount coupon' : 'Sorry no Coupon Won !'}',
            buttons: [
              DialogButton(
                color: Colors.yellowAccent,
                onPressed: () => Navigator.popAndPushNamed(context, 'sc1'),
                child: Text(
                  'Close',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ]).show();
        quizBrain.reset();
        scoreKeeper = [];
        score = 0;
        lives = 4;
        liveKeeper = List<Icon>.generate(
            4,
            (i) => Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 30.0,
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                'Lives Remaining: $lives',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            Row(
              children: liveKeeper,
            ),
          ],
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionBank(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

class Data extends ChangeNotifier {
  //For notifying listeners
  int data = 0;

  void changeData(int newData) {
    data = newData;
    notifyListeners();
  }
}
