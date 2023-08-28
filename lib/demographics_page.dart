import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class DemographicsPage extends StatefulWidget {
  @override
  _DemographicsPageState createState() => _DemographicsPageState();
}

class _DemographicsPageState extends State<DemographicsPage> {
  Map<String, dynamic> demographics = {};

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/demographics.json');
    final data = await json.decode(response);
    setState(() {
      demographics = data;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demographics',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily),
        ),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: CustomDrawer(), // Including the custom drawer
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CardInfo(
                icon: Icons.person,
                color: Colors.green,
                label: 'First Name',
                value: demographics['firstName'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.person,
                color: Colors.orange,
                label: 'Last Name',
                value: demographics['lastName'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.wc,
                color: Colors.blue,
                label: 'Gender',
                value: demographics['gender'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.people,
                color: Colors.pink,
                label: 'Marital Status',
                value: demographics['maritalStatus'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.add_location,
                color: Colors.red,
                label: 'Religious Affiliation',
                value: demographics['religiousAffiliation'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.face,
                color: Colors.purple,
                label: 'Ethnicity',
                value: demographics['ethnicity'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.language,
                color: Colors.blueGrey,
                label: 'Language',
                value: demographics['language'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.location_on,
                color: Colors.red,
                label: 'Address',
                value: demographics['address'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.phone,
                color: Colors.purple,
                label: 'Telephone',
                value: demographics['telephone'] ?? '',
              ),
              SizedBox(height: 10),
              CardInfo(
                icon: Icons.cake,
                color: Colors.teal,
                label: 'Birthday',
                value: demographics['birthday'] ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const CardInfo({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: color),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    '$label: $value',
                    style: TextStyle(fontSize: 16),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
