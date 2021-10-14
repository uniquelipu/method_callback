import 'package:flutter/material.dart';
import 'callbacks.dart';

void main() => runApp(PlaygroundApp());

class PlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerPlayground(title: 'Timer Playground'),
    );
  }
}

class TimerPlayground extends StatefulWidget {
  TimerPlayground({Key key, this.title}) : super(key: key);

  final String title;

  @override
  TimerPlaygroundState createState() => TimerPlaygroundState();
}

class TimerPlaygroundState extends State<TimerPlayground> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Press button to start updating time in every 10 seconds"),
              ),
              Text(logs, style: TextStyle(fontSize: 26),)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: runPlayground,
          tooltip: 'Run Playground',
          child: Icon(Icons.play_arrow),
        )
    );
  }

  /////////////// Playground ///////////////////////////////////////////////////
  String logs = "";

  // Call inside a setState({ }) block to be able to reflect changes on screen
  void log(String logString) {
    setState(() {
      logs = logString.toString();
    });
  }

  // Main function called when playground is run
  bool running = false;
  void runPlayground() async {
    if (running) return;
    running = true;

    var startTimer = await startListening((msg) {
      setState(() {
        log(msg);
      });
    });

    await Future.delayed(Duration(seconds: 10));

    startTimer();

    // running = false;
  }
}