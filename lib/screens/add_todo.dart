import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/models/todo.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});
  TextEditingController titleController = TextEditingController();
  Box todoBox = Hive.box<Todo>("todo");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: "Title", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text != '') {
                    Todo todo =
                        Todo(title: titleController.text, isCompleted: false);
                    todoBox.add(todo);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add Todo",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
