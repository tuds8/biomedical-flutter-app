import 'package:flutter/material.dart';
import 'allergies_page.dart';
import 'immunizations_page.dart';
import 'medication_page.dart';
import 'problem_list_page.dart';
import 'procedures.dart';
import 'guardian_page.dart';
import 'demographics_page.dart';
import 'plan_of_care_page.dart';
import 'custom_drawer_menu.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false, // Aligning the title to the left
        title: Text(
          'Home Page',
          style: TextStyle(
            fontFamily: GoogleFonts.playfairDisplay().fontFamily,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: const CustomDrawer(), // Including the custom drawer
      body: Container(
        color: Colors.grey[300], // Setting the background color to grey
        child: ListView(
          padding: EdgeInsets.zero, // Removing the padding
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.ac_unit_rounded,
                    color: Colors.red,
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Welcome, Ellen Ross!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(), // Adding a divider between the welcome text and the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Allergies',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllergiesPage()),
                );
              },
            ),
            const Divider(), // Adding a divider between the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.healing,
                    color: Colors.green,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Immunizations',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImmunizationsPage()),
                );
              },
            ),
            const Divider(), // Adding a divider between the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.medication,
                    color: Colors.orange,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Medication',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MedicationPage()),
                );
              },
            ),
            const Divider(), // Adding a divider between the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.assignment,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Problem List',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProblemListPage()),
                );
              },
            ),
            const Divider(), // Adding a divider between the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.medical_services,
                    color: Colors.deepPurple,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Procedures',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProceduresPage()),
                );
              },
            ),
            const Divider(), // Adding a divider between the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.red,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Guardian',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GuardianPage()),
                );
              },
            ),
            const Divider(), // Adding a divider between the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.teal,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Demographics',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DemographicsPage()),
                );
              },
            ),
            const Divider(), // Adding a divider between the cards
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.assignment_turned_in,
                    color: Colors.amber,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Plan of Care',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlanOfCarePage()),
                );
              },
            ),
            const Divider(), // Adding a divider after the last page name
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: FloatingActionButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
