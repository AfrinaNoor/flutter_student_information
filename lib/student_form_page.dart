import 'package:flutter/material.dart';
import 'database_helper.dart';

class StudentFormPage extends StatefulWidget {
  final Map<String, dynamic>? student;

  StudentFormPage({this.student});

  @override
  _StudentFormPageState createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nameController.text = widget.student!['name'];
      idController.text = widget.student!['studentId'];
      phoneController.text = widget.student!['phone'];
      emailController.text = widget.student!['email'];
      locationController.text = widget.student!['location'];
    }
  }

  _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> student = {
        'name': nameController.text,
        'studentId': idController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'location': locationController.text
      };

      if (widget.student == null) {
        await DatabaseHelper().insertStudent(student);
      } else {
        await DatabaseHelper().updateStudent(widget.student!['id'], student);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Form'),
        backgroundColor: Colors.teal, // Customize the app bar color
        iconTheme: IconThemeData(color: Colors.white), // Set the back arrow color to white
        titleTextStyle: TextStyle(color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView( // Allows scrolling if the keyboard appears
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Makes sure the form fields stretch across the screen
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Name must contain only alphabets';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'Student ID',
                    prefixIcon: Icon(Icons.perm_identity),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the student ID';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
                    } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                      return 'Phone number must be 11 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email address';
                    } else if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveStudent,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.teal, // Customize button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners for the button
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
