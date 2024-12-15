import 'package:flutter/material.dart';
import 'student_list_page.dart';
import 'student_form_page.dart';

void main() {
  runApp(StudentApp());
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.purple.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Student Information App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              _buildRoundedButton(
                text: "Add Student",
                icon: Icons.person_add,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentFormPage()),
                ),
              ),
              SizedBox(height: 15),
              _buildRoundedButton(
                text: "View All Students",
                icon: Icons.list,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentListPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedButton({required String text, required IconData icon, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade700,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}
