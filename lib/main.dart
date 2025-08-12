import 'package:flutter/material.dart';

void main() {
  runApp(TaskTimelineApp());
}

class TaskTimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Timeline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: TaskTimelineScreen(),
    );
  }
}

class TaskTimelineScreen extends StatefulWidget {
  @override
  _TaskTimelineScreenState createState() => _TaskTimelineScreenState();
}

class _TaskTimelineScreenState extends State<TaskTimelineScreen> {
  List<Task> tasks = [
    Task("Wireframing", "12:00 PM",
        "Make some ideation from sketch and wireframes.", Colors.red),
    Task("UI Design", "1:30 PM",
        "Visual design from wireframe and make design system.", Colors.orange),
    Task("Prototyping", "3:00 PM",
        "Make the interactive prototype for testing.", Colors.purple),
    Task("Usability Testing", "3:45 PM",
        "Primary user testing and testing the prototype.", Colors.teal),
    Task("Meeting", "4:30 PM", "Discussion with stakeholders.",
        Colors.yellow[800]!),
  ];

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final descController = TextEditingController();

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: "Title")),
                TextField(
                    controller: timeController,
                    decoration: InputDecoration(labelText: "Time")),
                TextField(
                    controller: descController,
                    decoration: InputDecoration(labelText: "Description")),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    timeController.text.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(
                      titleController.text,
                      timeController.text,
                      descController.text,
                      Colors.blueAccent,
                    ));
                  });
                  titleController.clear();
                  timeController.clear();
                  descController.clear();
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showAddTaskDialog,
              icon: Icon(Icons.add),
              label: Text("Add Task"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: StadiumBorder(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: task.color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${task.title} - ${task.time}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text(task.description,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String title;
  final String time;
  final String description;
  final Color color;

  Task(this.title, this.time, this.description, this.color);
}
