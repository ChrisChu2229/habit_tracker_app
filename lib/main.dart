import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = "Habit Tracker";
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: appTitle),
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
  int _counter = 0;

  // list for holding habits
  List<String> _habits = [];

  void _addHabit() {
    // Create a controller to retrieve text from the TextField
    TextEditingController _habitController = TextEditingController();

    // Show a dialog to enter the new habit
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Habit"),
          content: TextField(
            controller: _habitController,
            decoration: InputDecoration(hintText: "Enter habit name"),
          ),
          actions: [
            TextButton(
              child: Text("Add"),
              onPressed: () {
                // get teh text from the controller
                String newHabit = _habitController.text.trim();
                if (newHabit.isNotEmpty) {
                  // update the state with the new habit
                  setState(() {
                    _habits.add(newHabit);
                  });
                  Navigator.of(context).pop(); // close the dialog
                }
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _habits.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("No habits added yet!"),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_habits[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      // Handle habit done later
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        tooltip: 'Add Habit',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
