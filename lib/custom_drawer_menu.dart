import 'package:flutter/material.dart';
import 'allergies_page.dart';
import 'immunizations_page.dart';
import 'medication_page.dart';
import 'problem_list_page.dart';
import 'procedures.dart';
import 'guardian_page.dart';
import 'demographics_page.dart';
import 'plan_of_care_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.blue, // Setting the background color to blue
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0), // Adjusting the top padding
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300], // Setting the background color to grey
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'Allergies',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AllergiesPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Immunizations',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ImmunizationsPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Medication',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MedicationPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Problem List',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProblemListPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Procedures',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProceduresPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Guardian',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GuardianPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Demographics',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DemographicsPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Plan of Care',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Setting the text color to black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlanOfCarePage()),
                      );
                    },
                  ),
                  const Divider(), // Adding one more divider after the Plan of Care page
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
