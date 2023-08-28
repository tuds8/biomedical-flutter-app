import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_drawer_menu.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlanOfCarePage extends StatefulWidget {
  @override
  _PlanOfCarePageState createState() => _PlanOfCarePageState();
}

class _PlanOfCarePageState extends State<PlanOfCarePage> {
  List<dynamic> planOfCare = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/plan_of_care.json');
    final data = await json.decode(response);
    setState(() {
      planOfCare = data;
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
          'Plan of Care',
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0), // Adding padding above the first card
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.lightBlue[100], // Setting the background color of the card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.work, color: Colors.blue), // Planned Activity Icon
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                planOfCare.isNotEmpty
                                    ? planOfCare[0]['plannedActivityName']
                                    : '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today, color: Colors.green), // Planned Date Icon
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                planOfCare.isNotEmpty
                                    ? 'Date: ${planOfCare[0]['plannedDate']}'
                                    : '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(Icons.description, color: Colors.orange), // Instructions Icon
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                planOfCare.isNotEmpty
                                    ? 'Instructions: ${planOfCare[0]['instructions']}'
                                    : '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0), // Adding some distance
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: planOfCare.length > 1 ? planOfCare.length - 1 : 0, // Adjusting the itemCount
                separatorBuilder: (context, index) => SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  final itemIndex = index + 1;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.lightBlue[100], // Setting the background color of the card
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.work, color: Colors.blue), // Planned Activity Icon
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  planOfCare[itemIndex]['plannedActivityName'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today, color: Colors.green), // Planned Date Icon
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Date: ${planOfCare[itemIndex]['plannedDate']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Icon(Icons.description, color: Colors.orange), // Instructions Icon
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Instructions: ${planOfCare[itemIndex]['instructions']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0), // Adding some spacing before the chart
              Container(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    ColumnSeries<dynamic, String>(
                      dataSource: planOfCare.map((item) => item['plannedActivityName'] as String).toList(),
                      xValueMapper: (dynamic activity, _) => activity,
                      yValueMapper: (dynamic _, __) => 1, // Dummy value for column height
                      pointColorMapper: (dynamic activity, _) {
                        // Assigning different colors based on the index of the activity
                        final index = planOfCare.indexWhere((item) => item['plannedActivityName'] == activity);
                        if (index == 0) {
                          return Colors.blue;
                        } else if (index == 1) {
                          return Colors.red;
                        } else if (index == 2) {
                          return Colors.yellow;
                        } else {
                          return Colors.grey; // Fallback color
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
