import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ImmunizationsPage extends StatefulWidget {
  const ImmunizationsPage({super.key});

  @override
  _ImmunizationsPageState createState() => _ImmunizationsPageState();
}

class _ImmunizationsPageState extends State<ImmunizationsPage> {
  List immunizations = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/immunizations.json');
    final data = await json.decode(response);
    setState(() {
      immunizations = data;
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
          'Immunizations',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: immunizations.length,
          itemBuilder: (context, index) {
            List<Color> iconColors = [
              Colors.blue,
              Colors.red,
              Colors.green,
              Colors.orange,
              Colors.purple,
            ];

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.lightBlue[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildRow(
                      Icons.calendar_today,
                      'Date',
                      '${immunizations[index]['date']}',
                      iconColors[0],
                    ),
                    const SizedBox(height: 10),
                    buildRow(
                      Icons.local_hospital,
                      'Immunization Name',
                      '${immunizations[index]['immunizationName']}',
                      iconColors[1],
                    ),
                    const SizedBox(height: 10),
                    buildRow(
                      Icons.category,
                      'Type',
                      '${immunizations[index]['type']}',
                      iconColors[2],
                    ),
                    const SizedBox(height: 10),
                    buildRow(
                      Icons.format_list_numbered,
                      'Dose Quantity (value / unit)',
                      '${immunizations[index]['doseQuantity']}',
                      iconColors[3],
                    ),
                    const SizedBox(height: 10),
                    buildRow(
                      Icons.info,
                      'Education/Instructions',
                      '${immunizations[index]['instructions']}',
                      iconColors[4],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildRow(
    IconData icon,
    String title,
    String value,
    Color iconColor,
  ) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title:',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
