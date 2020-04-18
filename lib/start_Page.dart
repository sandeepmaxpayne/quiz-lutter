import 'package:flutter/material.dart';
import 'main.dart';
import 'scratch_card_diag.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quizz Game',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color(0xFF616161),
      body: PageLayout(),
    );
  }
}

class PageLayout extends StatefulWidget {
  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  int wonscratch;
  int remCard = 0;

  @override
  Widget build(BuildContext context) {
    wonscratch = Provider.of<Data>(context).data;

    print('remcard:$remCard');
    remCard = wonscratch;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Total Scratch Card Won: ${remCard.toString()}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Center(
            child: Text(
              "Welcome Palyer !",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.blue,
              child: Text('Play Game'),
              onPressed: () {
                Navigator.pushNamed(context, 'sc2');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: FlatButton(
              child: Image.asset('images/scratchimg.jpg'),
              onPressed: () {
                if (remCard > 0) {
                  remCard -= 1;
                  print(remCard);
                  ScratchDiag().ScratchCardDialog(context);
                } else {
                  Alert(
                      context: context,
                      title: 'Scratch Card',
                      desc:
                          'No more Scratch Card ! All used. \n Play Quiz Game to win more !',
                      buttons: [
                        DialogButton(
                          color: Colors.blue,
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Close',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]).show();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
