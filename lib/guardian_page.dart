import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class GuardianPage extends StatefulWidget {
  @override
  _GuardianPageState createState() => _GuardianPageState();
}

class _GuardianPageState extends State<GuardianPage> {
  Map<String, dynamic> guardian = {};

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/guardian.json');
    final data = await json.decode(response);
    setState(() {
      guardian = data;
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
          'Guardian',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.playfairDisplay().fontFamily,
          ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Icon(Icons.ac_unit_rounded, size: 40, color: Colors.red),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
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
                        Icon(Icons.work, color: Colors.blue), // Role Icon
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Role: ${guardian['role']}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.green), // First Name Icon
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'First Name: ${guardian['firstName']}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.orange), // Last Name Icon
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Last Name: ${guardian['lastName']}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.red), // Address Icon
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Address: ${guardian['address']}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone, color: Colors.purple), // Telephone Icon
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Telephone: ${guardian['telephone']}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
