import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  double value = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beta 3'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[200],
        elevation: 20.0,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.backspace),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.http),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // FloatingActionButton.extended()
        onPressed: () {
          controller.forward();
          if (controller.isCompleted) {
            controller.reverse();
          }
        },
        child: Icon(Icons.home),
        // label: Text('Go Home'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FAB(controller),
      body: Center(
          child: Column(
        children: <Widget>[
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.purple[300],
              child: Text('TP'),
            ),
            label: Text('Tensor-Programming'),
            onDeleted: () {},
            deleteIcon: Icon(Icons.delete_forever),
            deleteIconColor: Colors.purple[400],
          ),
          TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder()),
          ),
          TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                border: UnderlineInputBorder()),
          ),
          Slider(
            value: value,
            onChanged: (val) {
              setState(() => value = val.roundToDouble());
            },
            min: 0.0,
            max: 10.0,
            activeColor: Colors.purple,
            inactiveColor: Colors.lightBlue,
            divisions: 10,
          ),
        ],
      )),
    );
  }
}

class FAB extends FloatingActionButtonAnimator {
  final AnimationController controller;

  FAB(
    this.controller,
  );

  @override
  Offset getOffset({Offset begin, Offset end, double progress}) {
    if (progress == 0.0) {
      return begin;
    } else {
      return end;
    }
  }

  @override
  Animation<double> getScaleAnimation({Animation<double> parent}) {
    return TrainHoppingAnimation(
      Tween<double>(begin: 1.0, end: -1.0).animate(controller),
      Tween<double>(begin: -1.0, end: 1.0).animate(controller),
    );
  }

  @override
  Animation<double> getRotationAnimation({Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: -1.0).animate(controller);
  }
}
