import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String name;
  final String branch;
  final String schoolName;
  final String rollNumber;

  User({
    required this.name,
    required this.branch,
    required this.schoolName,
    required this.rollNumber,
  });
}

class MyApp extends StatelessWidget {
  static ThemeMode currentThemeMode = ThemeMode.light;

  static void switchThemeMode(ThemeMode mode) {
    currentThemeMode = mode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: currentThemeMode,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? currentUser;

  @override
  void initState() {
    // Simulating a user login. Replace this with actual authentication logic.
    currentUser = User(
      name: 'John Doe',
      branch: 'Computer Science',
      schoolName: 'ABC School',
      rollNumber: '12345',
    );
    super.initState();
  }

  Future<void> _pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg'],
      );

      if (result != null) {
        // Handle the selected file
        PlatformFile file = result.files.single;
        List<int> fileBytes = file.bytes!;
        print('File picked: ${file.name}');

        // Display upload confirmation message
        _showUploadSuccess(context);
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void _showUploadSuccess(BuildContext context) {
    // Display a snackbar with upload confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File uploaded successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_image.jpg'), // Placeholder image
                  radius: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome, ${currentUser?.name ?? 'Guest'}!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    _pickFile(context);
                  },
                  child: Text('Upload PDF/Image'),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: Text(
                    'Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    _showProfileDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.black),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.feedback, color: Colors.black),
                  title: Text(
                    'Feedback',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    // Navigate to the feedback screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.library_books, color: Colors.black),
                  title: Text(
                    'Test Level',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestLevelScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${currentUser?.name ?? 'Guest'}'),
              Text('Branch: ${currentUser?.branch ?? 'N/A'}'),
              Text('School: ${currentUser?.schoolName ?? 'N/A'}'),
              Text('Roll Number: ${currentUser?.rollNumber ?? 'N/A'}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.create.vista.com/api/media/medium/259495192/stock-photo-vector-settings-icon?token='),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    "Notifications",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Switch(
                    value: notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Switch(
                    value: darkModeEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        darkModeEnabled = value;
                        MyApp.switchThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Sound",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Switch(
                    value: soundEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        soundEnabled = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("About Test Formatter"),
                            content: Text(
                                "Well hello, test formatter—you're in the right place. "
                                    "Instead of printing out piles of paper to hand out to your employees or pupils, choose an online test. A typeform looks great, is fun to take—and bad handwriting free."),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontSize: 24.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestLevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle high-level test
              },
              child: Text('High'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle medium-level test
              },
              child: Text('Medium'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle easy-level test
              },
              child: Text('Easy'),
            ),
          ],
        ),
      ),
    );
  }
}
