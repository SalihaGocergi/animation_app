import 'dart:math';

import 'package:flutter/material.dart';

class RotateWidget extends StatefulWidget {
  @override
  RotateWidgetState createState() => RotateWidgetState();
}

class RotateWidgetState extends State<RotateWidget>
    with SingleTickerProviderStateMixin {
  bool _loadingInProgress;

  Animation<double> _angleAnimation;

  Animation<double> _scaleAnimation;

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 360.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _scaleAnimation = new Tween(begin: 1.0, end: 6.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_loadingInProgress) {
          print("Bitti");
          /*
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => new LoadingScreen()));

           */
          //_controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (_loadingInProgress) {
          _controller.forward();
        }
      }
    });

    _controller.forward();

    //_loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleWidth = 20.0 * _scaleAnimation.value;
    Widget circles = new Container(
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                width: circleWidth,
                height: circleWidth,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage("assets/cloudy.png"),
                  fit: BoxFit.fitHeight,
                )),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: circleWidth,
                height: circleWidth,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage("assets/rain.png"),
                  fit: BoxFit.fitHeight,
                )),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                width: circleWidth,
                height: circleWidth,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage("assets/snowflakes.png"),
                  fit: BoxFit.fitHeight,
                )),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: circleWidth,
                height: circleWidth,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                  image: new AssetImage("assets/sunset.png"),
                  fit: BoxFit.fitHeight,
                )),
              ),
            ],
          ),
        ],
      ),
    );

    double angleInDegrees = _angleAnimation.value;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF4e89ae),
              Color(0xFFa2d5f2),
              Color(0xFF4e89ae)
            ]),
      ),
      child: new Transform.rotate(
        angle: angleInDegrees / 360 * 2 * pi,
        child: Center(
          child: new Container(
            child: circles,
          ),
        ),
      ),
    );
  }
}
