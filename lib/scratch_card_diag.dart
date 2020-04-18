import 'dart:ui';

import 'package:scratcher/scratcher.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ScratchDiag {
  double _opacity = 0.0;

  Future<void> ScratchCardDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            title: Text('You won'),
            content: StatefulBuilder(
              builder: (context, StateSetter setstate) {
                return Scratcher(
                  accuracy: ScratchAccuracy.low,
                  color: Colors.orange,
                  threshold: 25,
                  onThreshold: () {
                    setstate(() {
                      _opacity = 1;
                    });
                  },
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 250),
                    opacity: _opacity,
                    child: Container(
                      height: 300,
                      width: 300,
                      alignment: Alignment.center,
                      child: Text(
                        '₹ ${Random().nextInt(100)}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
