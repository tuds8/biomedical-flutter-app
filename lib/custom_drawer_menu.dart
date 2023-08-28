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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue, // Setting the background color to blue
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0), // Adjusting the top padding
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
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => AllergiesPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => ImmunizationsPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => MedicationPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => ProblemListPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => ProceduresPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => GuardianPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => DemographicsPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
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
                        MaterialPageRoute(builder: (context) => PlanOfCarePage()),
                      );
                    },
                  ),
                  Divider(), // Adding one more divider after the Plan of Care page
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
