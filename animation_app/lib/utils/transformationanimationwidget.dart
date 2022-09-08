import 'dart:math';

import 'package:flutter/material.dart';

import '../anasayfa.dart';

class TransformationAnimationWidget extends StatefulWidget {
  @override
  TransformationAnimationWidgetState createState() =>
      TransformationAnimationWidgetState();
}

class TransformationAnimationWidgetState
    extends State<TransformationAnimationWidget>
    with SingleTickerProviderStateMixin {
  //AnimationController _controller;
  //Animation<double> transitionTween;
  //Animation<BorderRadius> borderRadius;

  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    /*
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => new Anasayfa()));
        }
      });

    transitionTween = Tween<double>(
      begin: 50.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(75.0),
      end: BorderRadius.circular(0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _controller.forward();

     */
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 50.0, end: 200.0).animate(_controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          print("completed");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => new Anasayfa()));
        } else if (state == AnimationStatus.dismissed) {
          print("dismissed");
        }
      })
      ..addListener(() {
        print("value:${_animation.value}");
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
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
                    alignment: AlignmentDirectional.center,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Transform.rotate(
                                  angle: -2 * pi * _animation.value / 200,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                      image:
                                          new AssetImage("assets/cloudy.png"),
                                      fit: BoxFit.fitHeight,
                                    )),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: -2 * pi * _animation.value / 200,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                      image: new AssetImage("assets/rain.png"),
                                      fit: BoxFit.fitHeight,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.rotate(
                                  angle: -2 * pi * _animation.value / 200,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                      image: new AssetImage(
                                          "assets/snowflakes.png"),
                                      fit: BoxFit.fitHeight,
                                    )),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: -2 * pi * _animation.value / 200,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                      image:
                                          new AssetImage("assets/sunset.png"),
                                      fit: BoxFit.fitHeight,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /*new Center(
          child: Container(
            alignment: Alignment.bottomCenter,
            width: transitionTween.value,
            height: transitionTween.value,
            decoration: BoxDecoration(
                //color: Colors.deepPurple,
                borderRadius: borderRadius.value,
                image: new DecorationImage(
                  image: new AssetImage("assets/logo.png"),
                  fit: BoxFit.fill,
                )),
          ),
        ),*/
        );
      },
    );
  }
}
