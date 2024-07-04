import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const StopWatch());
}

class StopWatch extends StatelessWidget {
  const StopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter StopWatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  void _startStopwatch() {
    if (_isRunning) {
      _pauseStopwatch();
    } else {
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          _milliseconds += 10;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _pauseStopwatch() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetStopwatch() {
    _timer.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int milliseconds) {
    int minutes = (milliseconds ~/ (60 * 1000)) % 60;
    int seconds = (milliseconds ~/ 1000) % 60;
    int millis = (milliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${millis.toString().padLeft(2, '0')}';
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 0, 0),
          const Color.fromARGB(255, 255, 232, 23)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 90,
          centerTitle: true,
          title: Text(
            'StopWatch',
            style: TextStyle(
              fontFamily: 'forte',
              fontSize: 50,
              foreground: Paint()
                ..strokeWidth = 3
                ..style = PaintingStyle.stroke
                ..color = Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF031F2C),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.white,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  style: BorderStyle.solid,
                  width: 5)),
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  rotateText(),
                  Text(
                    'ghalibthassan@gmail.com',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'blackitalic'),
                  )
                ],
              ),
              Stack(children: [
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      color: const Color.fromARGB(255, 41, 41, 41),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 2,
                            color: Colors.black)
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 380,
                    width: 380,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  border: Border.all(
                                      color: Colors.yellow, width: 5)),
                              child: Center(
                                child: Text(
                                  _formatTime(_milliseconds),
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    blurRadius: 2.5,
                                    spreadRadius: 2.5,
                                    color: Color(0xFF323232)),
                              ], borderRadius: BorderRadius.circular(10)),
                              width: 100,
                              height: 60,
                              child: FloatingActionButton(
                                isExtended: true,
                                backgroundColor: Colors.yellow,
                                onPressed: _startStopwatch,
                                mini: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _isRunning ? 'Pause' : 'Start',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2.5,
                                        spreadRadius: 2.5,
                                        color: Color(0xFF323232)),
                                  ],
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: FloatingActionButton(
                                isExtended: true,
                                mini: false,
                                backgroundColor: Colors.black,
                                onPressed: _resetStopwatch,
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class rotateText extends StatelessWidget {
  const rotateText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0010) // Perspective
        ..rotateX(math.pi / 4), // X rotation angle (tilt forward)
      child: Transform.rotate(
        angle: -math.pi / 500, // Z rotation angle (tilt sideways)
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Welcome to MyStopWatch',
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'blackitalic',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
