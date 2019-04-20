import 'package:flutter/material.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';

//CounterPage with a increase button and some text
class CounterPage extends StatefulWidget {
  //optional attributes with default value (so title will never be null!)
  CounterPage({this.title = "Counter"});

  final String title;

  @override
  _CounterPageState createState() => _CounterPageState();
}

//The state for the counter page (_ means just in this file referenceable)
class _CounterPageState extends State<CounterPage> {
  int _counter = 0; //private counter variable

  //method to increment the counter variable by 1
  void _incrementCounter() {
    setState(() {
      //just as a note: setState is needed to change instate variables
      // and it will rebuild the widgets!!!
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MyWidgetCreator.getDrawer(context),
      body: Center(
        //horizontally centered
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //used to the center vertically
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      //floating action buttons are usually in the lower left corner in front of the content
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        //call the increment counter method on button pressed
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
