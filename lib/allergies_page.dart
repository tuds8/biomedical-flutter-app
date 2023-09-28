import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({super.key});

  @override
  _AllergiesPageState createState() => _AllergiesPageState();
}

class _AllergiesPageState extends State<AllergiesPage> {
  List<dynamic> allergies = []; // List to store allergy data
  final _formKey = GlobalKey<FormState>(); // GlobalKey to identify and validate the form
  String allergyName = ''; // Variable to store the entered allergy name
  String reaction = ''; // Variable to store the entered reaction
  String severity = ''; // Variable to store the entered severity
  File? _image; // Variable to store the selected image

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    String data = await rootBundle.loadString('assets/allergies.json'); // Loading allergy data from a JSON file
    setState(() {
      allergies = json.decode(data); // Updating the list with the loaded data
    });
  }

  Icon getSeverityIcon(String severity) {
    // Helper function to get the severity icon based on the severity level
    switch (severity.toLowerCase()) {
      case 'moderate':
        return const Icon(Icons.error, color: Colors.yellow);
      case 'moderate to severe':
        return const Icon(Icons.error, color: Colors.orange);
      case 'severe':
        return const Icon(Icons.error, color: Colors.red);
      default:
        return const Icon(Icons.error, color: Colors.purple);
    }
  }

  Color getSeverityColor(String severity) {
    // Helper function to get the severity color based on the severity level
    switch (severity.toLowerCase()) {
      case 'moderate':
        return Colors.yellow[100]!;
      case 'moderate to severe':
        return Colors.orange[100]!;
      case 'severe':
        return Colors.red[100]!;
      default:
        return Colors.purple[100]!;
    }
  }

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera); // Opening the camera to capture an image
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path); // Setting the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar with title and navigation icons
        title: Text(
          'Allergies',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.playfairDisplay().fontFamily,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const CustomDrawer(), // Including the custom drawer
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // List of allergy items
              itemCount: allergies.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shadowColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: getSeverityColor(allergies[index]['severity']), // Setting the color based on severity
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: getSeverityIcon(allergies[index]['severity']), // Setting the icon based on severity
                    title: Text(
                      allergies[index]['allergyName'], // Displaying the allergy name
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Reaction: ${allergies[index]['reaction']}', // Displaying the reaction
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Severity: ${allergies[index]['severity']}', // Displaying the severity
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey, // Assigning the key to the form
              child: Column(
                children: [
                  Container(
                    // Container for allergy name field
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Allergy Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.medical_services, color: Colors.green), // Adding prefix icon
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the allergy name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        allergyName = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    // Container for reaction field
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Reaction',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.flash_on, color: Colors.yellow), // Adding prefix icon
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the reaction';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        reaction = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    // Container for severity field
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Severity',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.error, color: Colors.red), // Adding prefix icon
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the severity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        severity = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save(); // Saving form values
                        setState(() {
                          allergies.add({
                            'allergyName': allergyName,
                            'reaction': reaction,
                            'severity': severity,
                          }); // Adding new allergy data to the list
                          allergyName = '';
                          reaction = '';
                          severity = '';
                          _image = null;
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 16),
                  _image != null
                      ? Image.file(
                          _image!,
                          height: 100,
                        )
                      : const SizedBox(),
                  ElevatedButton(
                    onPressed: _uploadPhoto,
                    child: const Text('Upload Photo'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
