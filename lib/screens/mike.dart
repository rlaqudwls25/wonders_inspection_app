import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mic_stream/mic_stream.dart';

enum Command {
  start,
  stop,
  change,
}

const AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT;

class Mike extends StatefulWidget {

  @override
  _MikeState createState() => _MikeState();
}

class _MikeState extends State<Mike> with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  Stream<List<int>> stream;
  StreamSubscription<List<int>> listener;
  List<int> currentSamples;

  // Refreshes the Widget for every possible tick to force a rebuild of the sound wave
  AnimationController controller;

  Color _iconColor = Colors.white;
  bool isRecording = false;
  bool memRecordingState = false;
  bool isActive;
  DateTime startTime;

  // variables for screen size
  double width;
  double height;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setState(() {
      initPlatformState();
    });
  }

  // Responsible for switching between recording / idle state
  void _controlMicStream({Command command: Command.change}) async {
    switch (command) {
      case Command.change:
        _changeListening();
        break;
      case Command.start:
        _startListening();
        break;
      case Command.stop:
        _stopListening();
        break;
    }
  }

  bool _changeListening() =>
      !isRecording ? _startListening() : _stopListening();

  bool _startListening() {
    if (isRecording) return false;
    stream = microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: 16000,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AUDIO_FORMAT);

    setState(() {
      isRecording = true;
      startTime = DateTime.now();
    });

    print("Start Listening to the microphone");
    listener = stream.listen((samples) => currentSamples = samples);
    return true;
  }

  bool _stopListening() {
    if (!isRecording) return false;
    print("Stop Listening to the microphone");
    listener.cancel();

    setState(() {
      isRecording = false;
      currentSamples = null;
      startTime = null;
    });
    return true;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
    isActive = true;

    controller =
    AnimationController(duration: Duration(seconds: 1), vsync: this)
      ..addListener(() {
        if (isRecording) setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          controller.reverse();
        else if (status == AnimationStatus.dismissed) controller.forward();
      })
      ..forward();
  }

  Color _getBgColor() => (isRecording) ? Colors.red : Colors.cyan;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '마이크',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[

                  Container(
                    height: height / 2,
                    width: width,
                  ),

                  Center(
                    child: GestureDetector(
                      onTap: _controlMicStream,
                      child: Container(
                        height: 100,
                        width: 100,
                        child: (isRecording) ? Icon(
                            Icons.stop, size: 80, color: Colors.white) : Icon(
                            Icons.keyboard_voice, size: 80,
                            color: Colors.white),
                        decoration: BoxDecoration(
                            color: (isRecording) ? Colors.red : Colors.cyan,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[500],
                                offset: Offset(4.0, 4.0),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,),
                            ]
                        ),
                      ),
                    ),
                  ),

                  CustomPaint(
                      painter: WavePainter(
                          currentSamples, _getBgColor(), context)
                  ),
                  Positioned(
                      bottom: -100,
                      left: width / 2 - 100,
                      child: Text('마이크 버튼을 눌러보세요.',
                          style: TextStyle(fontSize: 20))),
                ],
              ),
            ],
          )
      )
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      isActive = true;
      print("Resume app");

      _controlMicStream(
          command: memRecordingState ? Command.start : Command.stop);
    } else if (isActive) {
      memRecordingState = isRecording;
      _controlMicStream(command: Command.stop);

      print("Pause app");
      isActive = false;
    }
  }

  @override
  void dispose() {
    listener.cancel();
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  List<int> samples;
  List<Offset> points;
  Color color;
  BuildContext context;
  Size size;

  // Set max val possible in stream, depending on the config
  final int absMax = (AUDIO_FORMAT == AudioFormat.ENCODING_PCM_8BIT) ? 127 : 32767;

  WavePainter(this.samples, this.color, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    this.size = context.size;
    size = this.size;

    Paint paint = new Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    points = toPoints(samples);

    Path path = new Path();
    path.addPolygon(points, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldPainting) => true;

  // Maps a list of ints and their indices to a list of points on a cartesian grid
  List<Offset> toPoints(List<int> samples) {
    List<Offset> points = [];
    if (samples == null)
      samples =
      List<int>.filled(size.width.toInt(), (0.5 * size.height).toInt());
    for (int i = 0; i < min(size.width, samples.length).toInt(); i++) {
      points.add(
          new Offset(i.toDouble(), project(samples[i], absMax, size.height)));
    }
    return points;
  }

  double project(int val, int max, double height) {
    double waveHeight = (max == 0) ? val.toDouble() : (val / max) * 0.5 * height;
    return waveHeight + 0.5 * height;
  }
}
