import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'student_form_page.dart';

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Map<String, dynamic>> students = [];

  _refreshStudents() async {
    final data = await DatabaseHelper().getAllStudents();
    setState(() => students = data);
  }

  _deleteStudent(int id) async {
    await DatabaseHelper().deleteStudent(id);
    _refreshStudents();
  }

  @override
  void initState() {
    super.initState();
    _refreshStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Students'),
        backgroundColor: Colors.teal, // Customize the app bar color
        iconTheme: IconThemeData(color: Colors.white), // Set the back arrow color to white
        titleTextStyle: TextStyle(color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: students.isEmpty
          ? Center(child: Text('No students available', style: TextStyle(fontSize: 18)))
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Dismissible(
            key: Key(students[index]['id'].toString()),
            direction: DismissDirection.endToStart, // Swiping from right to left
            onDismissed: (direction) {
              _deleteStudent(students[index]['id']);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Student deleted')),
              );
            },
            background: Container(
              color: Colors.red, // Red background for delete action
              child: Icon(Icons.delete, color: Colors.white, size: 40),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                students[index]['name'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('ID: ${students[index]['studentId']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.teal),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StudentFormPage(student: students[index]),
                    )).then((_) => _refreshStudents()),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteStudent(students[index]['id']),
                  ),
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => StudentFormPage(student: students[index]),
              )).then((_) => _refreshStudents()),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal, // Consistent with other UI elements
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => StudentFormPage())).then((_) => _refreshStudents()),
      ),
    );
  }
}
