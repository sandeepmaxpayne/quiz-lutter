import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(q: 'You can lead a cow downstairs very easily.', a: false),
    Question(q: 'Pollution is the main cause of global warming.', a: true),
    Question(q: 'A slug\'s blood is green.', a: true),
    Question(q: 'Tom Marvolo Riddle was Lord Voldemort.', a: true),
    Question(q: 'Sandeep Dutta was always an idiot.', a: false),
    Question(
        q: 'Touchstone from \'As you Like It\' was a motley fool.', a: true),
    Question(q: 'India is a country.', a: true),
    Question(q: 'Did earth blast in 2020.', a: false),
    Question(q: 'Pig is dirty.', a: true),
    Question(q: 'Chickens eat man.', a: false),
    Question(q: 'Lucifer Morning is the fallen angel', a: true),
    Question(q: 'Hitler was a good dictator.', a: false),
  ];

  // make questionBank private and use encapsulation property

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
    print(_questionNumber);
  }

  String getQuestionBank() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionBankAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      print('returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
