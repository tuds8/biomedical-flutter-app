import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  // Defining the maximum character limit allowed, to prevent overflow
  static const int maxPrescriberNameLength = 30; 
  static const int maxMedicationNameLength = 30; 
  List<dynamic> medications = [];
  final _formKey = GlobalKey<FormState>();
  String medicationName = '';
  DateTime? selectedDate;
  String instructions = '';
  String doseQuantity = '';
  String rateQuantity = '';
  String prescriber = '';

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/medications.json');
    final data = await json.decode(response);
    setState(() {
      medications = data;
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
          'Medication',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Medications',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: medications.length,
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
                              const Icon(Icons.medical_services, color: Colors.blue), // Adding an icon before Medication Name field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Name: ${medications[index]['name']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, color: Colors.green), // Adding an icon before Date field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Date: ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(medications[index]['date']))}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.info, color: Colors.red), // Adding an icon before Instructions field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Instructions: ${medications[index]['instructions']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.format_list_numbered, color: Colors.orange), // Adding an icon before Dose Quantity field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Dose Quantity (value / unit): ${medications[index]['doseQuantity']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.format_list_numbered, color: Colors.purple), // Adding an icon before Rate Quantity field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Rate Quantity (value / unit): ${medications[index]['rateQuantity']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.person, color: Colors.teal), // Adding an icon before Prescriber field
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Prescriber: ${medications[index]['prescriber']}',
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
                'Medication Name Chart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300, // Adjusting the height of the chart container
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom, // Positioning the legend to the bottom
                    overflowMode: LegendItemOverflowMode.wrap, // Wrapping the legend items to prevent overflow
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<MedicationData, String>(
                      dataSource: _prepareMedicationData(),
                      xValueMapper: (MedicationData data, _) => data.medication,
                      yValueMapper: (MedicationData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%',
                      innerRadius: '50%',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Prescriber Chart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300, // Adjusting the height of the chart container
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom, // Positioning the legend to the bottom
                    overflowMode: LegendItemOverflowMode.wrap, // Wrapping the legend items to prevent overflow
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<PrescriberData, String>(
                      dataSource: _preparePrescriberData(),
                      xValueMapper: (PrescriberData data, _) => data.prescriber,
                      yValueMapper: (PrescriberData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%',
                      innerRadius: '50%',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Yearly Prescription Chart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.sourceSansPro().fontFamily),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300, // Adjusting the height of the chart container
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  series: <ChartSeries>[
                    ColumnSeries<YearData, int>(
                      dataSource: _prepareYearData(),
                      xValueMapper: (YearData data, _) => data.year,
                      yValueMapper: (YearData data, _) => data.count,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Add Medication',
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
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.medical_services, color: Colors.blue),
                          labelText: 'Name of Medication',
                          labelStyle: const TextStyle(fontSize: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name of the medication';
                          }
                          else if (value.length > maxMedicationNameLength) {
                            return 'Medication name is too long. Maximum $maxMedicationNameLength characters allowed.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          medicationName = value!;
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
                              border: const OutlineInputBorder(),
                              fillColor: Colors.grey[200],
                              filled: true,
                              prefixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                              labelText: 'Date',
                              labelStyle: const TextStyle(fontSize: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the date';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                            controller: TextEditingController(
                              text: selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : '',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.info, color: Colors.red),
                          labelText: 'Instructions',
                          labelStyle: const TextStyle(fontSize: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the instructions';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          instructions = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.format_list_numbered, color: Colors.orange),
                          labelText: 'Dose Quantity (value / unit)',
                          labelStyle: const TextStyle(fontSize: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the dose quantity';
                          } else if (!isValidQuantityFormat(value)) {
                            return 'Invalid format. Please use the format: value / unit';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          doseQuantity = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.format_list_numbered, color: Colors.purple),
                          labelText: 'Rate Quantity (value / unit)',
                          labelStyle: const TextStyle(fontSize: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the rate quantity';
                          } else if (!isValidQuantityFormat(value)) {
                            return 'Invalid format. Please use the format: value / unit';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          rateQuantity = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: const Icon(Icons.person, color: Colors.teal),
                          labelText: 'Name of Prescriber',
                          labelStyle: const TextStyle(fontSize: 16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name of the prescriber';
                          }
                          else if (value.length > maxPrescriberNameLength) {
                            return 'Prescriber name is too long. Maximum $maxPrescriberNameLength characters allowed.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          prescriber = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                medications.add({
                                  'name': medicationName,
                                  'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
                                  'instructions': instructions,
                                  'doseQuantity': doseQuantity,
                                  'rateQuantity': rateQuantity,
                                  'prescriber': prescriber,
                                });
                                medicationName = '';
                                selectedDate = null;
                                instructions = '';
                                doseQuantity = '';
                                rateQuantity = '';
                                prescriber = '';
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

  bool isValidQuantityFormat(String value) {
    final parts = value.split('/');
    if (parts.length != 2) {
      return false;
    }
    final String quantity = parts[0].trim();
    final String unit = parts[1].trim();
    if (quantity.isEmpty || unit.isEmpty) {
      return false;
    }
    final quantityValue = double.tryParse(quantity);
    return quantityValue != null;
  }

  List<MedicationData> _prepareMedicationData() {
    final Map<String, int> medicationCount = {};
    for (var medication in medications) {
      final String medicationName = medication['name'];
      medicationCount[medicationName] = (medicationCount[medicationName] ?? 0) + 1;
    }
    return medicationCount.entries.map((e) => MedicationData(e.key, e.value)).toList();
  }

  List<PrescriberData> _preparePrescriberData() {
    final Map<String, int> prescriberCount = {};
    for (var medication in medications) {
      final String prescriberName = medication['prescriber'];
      prescriberCount[prescriberName] = (prescriberCount[prescriberName] ?? 0) + 1;
    }
    return prescriberCount.entries.map((e) => PrescriberData(e.key, e.value)).toList();
  }

  List<YearData> _prepareYearData() {
    final Map<int, int> yearCount = {};
    for (var medication in medications) {
      final DateTime date = DateTime.parse(medication['date']);
      final int year = date.year;
      yearCount[year] = (yearCount[year] ?? 0) + 1;
    }
    return yearCount.entries.map((e) => YearData(e.key, e.value)).toList();
  }
}

class MedicationData {
  final String medication;
  final int count;

  MedicationData(this.medication, this.count);
}

class PrescriberData {
  final String prescriber;
  final int count;

  PrescriberData(this.prescriber, this.count);
}

class YearData {
  final int year;
  final int count;

  YearData(this.year, this.count);
}
