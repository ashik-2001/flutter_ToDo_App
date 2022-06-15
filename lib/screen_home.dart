import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todo_app/db/db_tetsing.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Center(
          child: Text(
            'ToDo App',
            style: TextStyle(color: Colors.black),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: AddTasksButton(),
      ),
    );
  }
}

class AddTasksButton extends StatefulWidget {
  const AddTasksButton({Key? key}) : super(key: key);

  @override
  State<AddTasksButton> createState() => _AddTasksButtonState();
}

class _AddTasksButtonState extends State<AddTasksButton> {
  List<String> entries = [];

  //final List<int> colorCodes = <int>[400, 700, 100];
  late int len = entries.length;
  var string = 'No Tasks';
  final tasksAddTbox = TextEditingController();
  var box = Hive.box('testBox');

  @override
  void initState() {
    super.initState();
    // Add listeners to this class
    storeToEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  //style: TextStyle(color: Colors.white),
                  controller: tasksAddTbox,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter tasks here",
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () {
                  // print(tasksAddTbox.text);
                  setState(() {
                    string = tasksAddTbox.text;
                    if (string.isNotEmpty) {
                      storeTakstoList(string);
                      len = entries.length;
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Type Something!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        ),
        Text('$len Tasks'),
        Expanded(
          child: ListView.separated(
            itemCount: len,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(entries[index]),
                trailing: IconButton(
                  onPressed: () {
                    // print(index);
                    setState(() {
                      deleteTasks(index);
                    });
                    // print(len);
                  },
                  icon: const Icon(Icons.remove_circle),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        )
      ],
    );
  }

  Future<void> storeToEntries() async {
    len = box.length;
    // box.add(string);
    // box.clear();
    entries.clear();
    for (var i = 0; i <= len; i++) {
      entries.add(box.getAt(i));
    }
  }

  Future<void> storeTakstoList(string) async {
    len = box.length;
    box.add(string);
    // box.clear();
    entries.clear();
    for (var i = 0; i <= len; i++) {
      entries.add(box.getAt(i));
    }
  }

  Future<void> deleteTasks(index) async {
    len = box.length;
    box.deleteAt(index);
    storeToEntries();
  }
}
