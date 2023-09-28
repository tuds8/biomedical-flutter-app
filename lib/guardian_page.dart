import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class GuardianPage extends StatefulWidget {
  const GuardianPage({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          const Icon(Icons.ac_unit_rounded, size: 40, color: Colors.red),
          const SizedBox(height: 20),
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
                        const Icon(Icons.work, color: Colors.blue), // Role Icon
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Role: ${guardian['role']}',
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.person, color: Colors.green), // First Name Icon
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'First Name: ${guardian['firstName']}',
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.person, color: Colors.orange), // Last Name Icon
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Last Name: ${guardian['lastName']}',
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.location_on, color: Colors.red), // Address Icon
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Address: ${guardian['address']}',
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.phone, color: Colors.purple), // Telephone Icon
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Telephone: ${guardian['telephone']}',
                            style: const TextStyle(fontSize: 16),
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
