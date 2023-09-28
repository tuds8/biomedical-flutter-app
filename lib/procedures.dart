import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ProceduresPage extends StatefulWidget {
  const ProceduresPage({super.key});

  @override
  _ProceduresPageState createState() => _ProceduresPageState();
}

class _ProceduresPageState extends State<ProceduresPage> {
  // Defining the maximum character limit allowed, to prevent overflow
  static const int maxProcedureNameLength = 30; 
  static const int maxProviderNameLength = 30;
  static const int maxLocationNameLength = 30;
  List<dynamic> procedures = [];
  final _formKey = GlobalKey<FormState>();
  String procedureTitle = '';
  DateTime? selectedDate;
  String provider = '';
  String location = '';

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/procedures.json');
    final data = await json.decode(response);
    setState(() {
      procedures = data;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  List<ProcedureData> _prepareProcedureData() {
    final Map<String, int> procedureCount = {};
    for (var procedure in procedures) {
      final String procedureName = procedure['procedure'];
      procedureCount[procedureName] = (procedureCount[procedureName] ?? 0) + 1;
    }
    return procedureCount.entries
        .map((e) => ProcedureData(e.key, e.value))
        .toList();
  }

  List<ProviderData> _prepareProviderData() {
    final Map<String, int> providerCount = {};
    for (var procedure in procedures) {
      final String providerName = procedure['provider'];
      providerCount[providerName] = (providerCount[providerName] ?? 0) + 1;
    }
    return providerCount.entries
        .map((e) => ProviderData(e.key, e.value))
        .toList();
  }

  List<LocationData> _prepareLocationData() {
    final Map<String, int> locationCount = {};
    for (var procedure in procedures) {
      final String locationName = procedure['location'];
      locationCount[locationName] = (locationCount[locationName] ?? 0) + 1;
    }
    return locationCount.entries
        .map((e) => LocationData(e.key, e.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Procedures',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily),
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
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Procedures',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: procedures.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.lightBlue[100], // Setting the background color of the card
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              const IconTheme(
                                data: IconThemeData(color: Colors.blue), // Setting the color of the icon
                                child: Icon(Icons.medical_services), // Adding an icon before Procedure field
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Procedure: ${procedures[index]['procedure']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const IconTheme(
                                data: IconThemeData(color: Colors.green), // Setting the color of the icon
                                child: Icon(Icons.calendar_today), // Adding an icon before Date field
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Date: ${procedures[index]['date']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const IconTheme(
                                data: IconThemeData(color: Colors.orange), // Setting the color of the icon
                                child: Icon(Icons.person), // Adding an icon before Provider field
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Provider: ${procedures[index]['provider']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const IconTheme(
                                data: IconThemeData(color: Colors.red), // Setting the color of the icon
                                child: Icon(Icons.location_on), // Adding an icon before Location field
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Location: ${procedures[index]['location']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Procedure Chart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400, // Adjusting the height of the chart container
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom, // Positioning the legend to the bottom
                    overflowMode: LegendItemOverflowMode.wrap, // Wrapping the legend items to prevent overflow
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<ProcedureData, String>(
                      dataSource: _prepareProcedureData(),
                      xValueMapper: (ProcedureData data, _) => data.procedure,
                      yValueMapper: (ProcedureData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%',
                      innerRadius: '50%',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Provider Chart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400, // Adjusting the height of the chart container
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom, // Positioning the legend to the bottom
                    overflowMode: LegendItemOverflowMode.wrap, // Wrapping the legend items to prevent overflow
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<ProviderData, String>(
                      dataSource: _prepareProviderData(),
                      xValueMapper: (ProviderData data, _) => data.provider,
                      yValueMapper: (ProviderData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%',
                      innerRadius: '50%',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Location Chart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400, // Adjusting the height of the chart container
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom, // Positioning the legend to the bottom
                    overflowMode: LegendItemOverflowMode.wrap, // Wrapping the legend items to prevent overflow
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<LocationData, String>(
                      dataSource: _prepareLocationData(),
                      xValueMapper: (LocationData data, _) => data.location,
                      yValueMapper: (LocationData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%',
                      innerRadius: '50%',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Add Procedure',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Procedure Title',
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.medical_services, color: Colors.blue), // Adding prefix icon
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the procedure title';
                          }
                          else if (value.length > maxProcedureNameLength) {
                            return 'Procedure name is too long. Maximum $maxProcedureNameLength characters allowed.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          procedureTitle = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              border: const OutlineInputBorder(),
                              fillColor: Colors.grey[200],
                              filled: true,
                              prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), // Adding prefix icon
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the date';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                            keyboardType: TextInputType.datetime,
                            controller: TextEditingController(
                              text: selectedDate != null
                                  ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                                  : '',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Provider',
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.person, color: Colors.orange), // Adding prefix icon
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the provider';
                          }
                          else if (value.length > maxProviderNameLength) {
                            return 'Provider name is too long. Maximum $maxProviderNameLength characters allowed.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          provider = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.location_on, color: Colors.red), // Adding prefix icon
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the location';
                          }
                          else if (value.length > maxLocationNameLength) {
                            return 'Location name is too long. Maximum $maxLocationNameLength characters allowed.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          location = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                procedures.add({
                                  'procedure': procedureTitle,
                                  'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
                                  'provider': provider,
                                  'location': location,
                                });
                                procedureTitle = '';
                                selectedDate = null;
                                provider = '';
                                location = '';
                              });
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class ProcedureData {
  final String procedure;
  final int count;

  ProcedureData(this.procedure, this.count);
}

class ProviderData {
  final String provider;
  final int count;

  ProviderData(this.provider, this.count);
}

class LocationData {
  final String location;
  final int count;

  LocationData(this.location, this.count);
}
