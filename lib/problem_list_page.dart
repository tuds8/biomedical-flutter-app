import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

class ProblemListPage extends StatefulWidget {
  const ProblemListPage({super.key});

  @override
  _ProblemListPageState createState() => _ProblemListPageState();
}

class _ProblemListPageState extends State<ProblemListPage> {
  // Defining the maximum character limit allowed, to prevent overflow
  static const int maxObservationLength = 30; 
  static const int maxStatusLength = 30;
  List<dynamic> problems = [];
  final _formKey = GlobalKey<FormState>();
  String observation = '';
  String status = '';
  DateTime? selectedDate;
  String comments = '';

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/problem_list.json');
    final data = await json.decode(response);
    setState(() {
      problems = data;
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
          'Problem List',
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
      endDrawer: const CustomDrawer(), // Including the custom drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Problem List',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: problems.length,
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
                              const Icon(Icons.label, color: Colors.blue), // Adding an icon before Observation field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Observation: ${problems[index]['observation']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.assignment, color: Colors.green), // Adding an icon before Status field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Status: ${problems[index]['status']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, color: Colors.orange), // Adding an icon before Date field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Date: ${problems[index]['date']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.comment, color: Colors.red), // Adding an icon before Comments field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Comments: ${problems[index]['comments']}',
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
                'Observation Chart',
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
                    DoughnutSeries<ObservationData, String>(
                      dataSource: _prepareObservationData(),
                      xValueMapper: (ObservationData data, _) => data.observation,
                      yValueMapper: (ObservationData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%',
                      innerRadius: '50%',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Status Chart',
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
                    DoughnutSeries<StatusData, String>(
                      dataSource: _prepareStatusData(),
                      xValueMapper: (StatusData data, _) => data.status,
                      yValueMapper: (StatusData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%',
                      innerRadius: '50%',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Add Problem',
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
                          labelText: 'Observation',
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.blue), // Setting the color of the icon
                            child: Icon(Icons.label), // Adding an icon before Observation field
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the observation';
                          }
                          else if (value.length > maxObservationLength) {
                            return 'Observation is too long. Maximum $maxObservationLength characters allowed.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          observation = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Status',
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.green), // Setting the color of the icon
                            child: Icon(Icons.assignment), // Adding an icon before Status field
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the status';
                          }
                          else if (value.length > maxStatusLength) {
                            return 'Status is too long. Maximum $maxStatusLength characters allowed.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          status = value!;
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
                              prefixIcon: const IconTheme(
                                data: IconThemeData(color: Colors.orange), // Setting the color of the icon
                                child: Icon(Icons.calendar_today), // Adding an icon before Date field
                              ),
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
                                  ? DateFormat('MMMM dd, yyyy').format(selectedDate!)
                                  : '',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Comments',
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.red), // Setting the color of the icon
                            child: Icon(Icons.comment), // Adding an icon before Comments field
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the comments';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          comments = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                problems.add({
                                  'observation': observation,
                                  'status': status,
                                  'date': DateFormat('MMMM dd, yyyy').format(selectedDate!),
                                  'comments': comments,
                                });
                                observation = '';
                                status = '';
                                selectedDate = null;
                                comments = '';
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

  List<ObservationData> _prepareObservationData() {
    final Map<String, int> observationCount = {};
    for (var problem in problems) {
      final String observationName = problem['observation'];
      observationCount[observationName] = (observationCount[observationName] ?? 0) + 1;
    }
    return observationCount.entries
        .map((e) => ObservationData(e.key, e.value))
        .toList();
  }

  List<StatusData> _prepareStatusData() {
    final Map<String, int> statusCount = {};
    for (var problem in problems) {
      final String statusName = problem['status'];
      statusCount[statusName] = (statusCount[statusName] ?? 0) + 1;
    }
    return statusCount.entries
        .map((e) => StatusData(e.key, e.value))
        .toList();
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

class ObservationData {
  final String observation;
  final int count;

  ObservationData(this.observation, this.count);
}

class StatusData {
  final String status;
  final int count;

  StatusData(this.status, this.count);
}
