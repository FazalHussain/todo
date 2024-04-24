import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/add_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box todoBox = Hive.box<Todo>("todo");
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo Application"),
      ),
      // ignore: sized_box_for_whitespace
      body: ValueListenableBuilder(
          valueListenable: todoBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return const Center(
                child: Text("No Todo Available!"),
              );
            } else {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    Todo todo = box.getAt(index);
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: todo.isCompleted ? Colors.green : Colors.black,
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          Todo newTodo =
                              Todo(title: todo.title, isCompleted: value!);
                          todoBox.putAt(index, newTodo);
                        },
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            todoBox.deleteAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("todo deleted successfully")));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    );
                  });
            }
          }),

      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTodo()));
          }),
    );
  }
}
