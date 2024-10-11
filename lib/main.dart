import 'package:flutter/material.dart';
import 'package:habit_tracker_app/habit.dart';

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

  // *old* list for holding habits
  // List<String> _habits = [];

  List<Habit> _habits = [];

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
                String newHabitName = _habitController.text.trim();
                if (newHabitName.isNotEmpty) {
                  // update the state with the new habit
                  setState(() {
                    _habits.add(Habit(name: newHabitName));
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
                  title: Text(
                    _habits[index].name,
                    style: TextStyle(
                      decoration: _habits[index].isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: Checkbox(
                    value: _habits[index].isCompleted,
                    onChanged: (bool? value) {
                      setState(() {
                        _habits[index].isCompleted = value ?? false;
                      });
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
