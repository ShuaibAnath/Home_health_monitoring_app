import 'dart:math';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';

class PatientDetailsPage extends StatefulWidget {
  static const String id = 'patient_details_page';
  const PatientDetailsPage({Key? key}) : super(key: key);

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  int _currentIndex = 0;
  List<String> headings = ['Temperature vs days', 'BPM vs days', 'Oxygen % vs days'];
  List<Widget> pages = [
    LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
              maxContentWidth: 100,
              tooltipBgColor: Colors.orangeAccent,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.gradient?.colors[0] ??
                        touchedSpot.bar.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  return LineTooltipItem(
                      '${DateFormat('yyyy-MM-dd').format(
                        DateTime.now().subtract(
                          Duration(
                            days: (21 - touchedSpot.x.toInt()),
                          ),
                        ),
                      )} , ${touchedSpot.y}',
                      textStyle);
                }).toList();
              }),
          handleBuiltInTouches: true,
          getTouchLineStart: (data, index) => 0,
        ),
        backgroundColor: Colors.black,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            axisNameWidget: const Text(
              'last 21 readings',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
            ),
          ),
          rightTitles: AxisTitles(
            axisNameWidget: Text(''),
          ),
          topTitles: AxisTitles(
            axisNameWidget: Text(''),
          ),
        ),
        minX: 0,
        maxX: 21,
        minY: 25,
        maxY: 50,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(21,
                (index) => FlSpot(index.toDouble(), Random().nextInt(5) + 38)),
            isCurved: true,
            barWidth: 5,
          ),
        ],
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xFF37434D), width: 1),
        ),
      ),
    ),
    LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            axisNameWidget: const Text(
              'last 21 readings',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
            ),
          ),
          rightTitles: AxisTitles(
            axisNameWidget: Text(''),
          ),
          topTitles: AxisTitles(
            axisNameWidget: Text(''),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
              maxContentWidth: 100,
              tooltipBgColor: Colors.orangeAccent,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.gradient?.colors[0] ??
                        touchedSpot.bar.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  return LineTooltipItem(
                      '${DateFormat('yyyy-MM-dd').format(
                        DateTime.now().subtract(
                          Duration(
                            days: (21 - touchedSpot.x.toInt()),
                          ),
                        ),
                      )} , ${touchedSpot.y}',
                      textStyle);
                }).toList();
              }),
          handleBuiltInTouches: true,
          getTouchLineStart: (data, index) => 0,
        ),
        backgroundColor: Colors.black,
        minX: 0,
        maxX: 21,
        minY: 40,
        maxY: 115,
        lineBarsData: [
          LineChartBarData(
            color: Colors.blueAccent,
            spots: List.generate(21,
                (index) => FlSpot(index.toDouble(), Random().nextInt(40) + 60)),
            isCurved: true,
            barWidth: 5,
          ),
        ],
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xFF37434D), width: 1),
        ),
      ),
    ),
    LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
              maxContentWidth: 100,
              tooltipBgColor: Colors.orangeAccent,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.gradient?.colors[0] ??
                        touchedSpot.bar.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  return LineTooltipItem(
                      '${DateFormat('yyyy-MM-dd').format(
                        DateTime.now().subtract(
                          Duration(
                            days: (21 - touchedSpot.x.toInt()),
                          ),
                        ),
                      )} , ${touchedSpot.y}',
                      textStyle);
                }).toList();
              }),
          handleBuiltInTouches: true,
          getTouchLineStart: (data, index) => 0,
        ),
        backgroundColor: Colors.black,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            axisNameWidget: const Text(
              'last 21 readings',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
            ),
          ),
          rightTitles: AxisTitles(
            axisNameWidget: Text(''),
          ),
          topTitles: AxisTitles(
            axisNameWidget: Text(''),
          ),
        ),
        minX: 0,
        maxX: 21,
        minY: 50,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            color: Colors.red,
            spots: List.generate(21,
                (index) => FlSpot(index.toDouble(), Random().nextInt(10) + 88)),
            isCurved: true,
            barWidth: 5,
          ),
        ],
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xFF37434D), width: 1),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Data'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth * 0.1,
            SizeConfig.screenHeight * 0.05,
            SizeConfig.screenWidth * 0.1,
            SizeConfig.screenHeight * 0.1),
        child:  Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                headings[_currentIndex],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(child: pages[_currentIndex]),
              UIComponents.createElevatedButton(
                TextButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding:
                  EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        SizeConfig.safeBlockHorizontal * 3),
                  ),
                ),
                    () {
                  print('Call cloud function to send email to hospital');
                },
                Text(
                  'ACCEPT PATIENT',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockVertical * 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ]
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.cyanAccent,
        animationDuration: const Duration(milliseconds: 500),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          }); //setState
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.thermostat),
              label: 'TEMPERATURE',
              selectedIcon: Icon(Icons.thermostat_outlined)),
          NavigationDestination(
              icon: Icon(Icons.favorite_border),
              label: 'BPM',
              selectedIcon: Icon(Icons.favorite)),
          NavigationDestination(
              icon: Icon(Icons.account_tree_outlined),
              label: 'Oxygen %',
              selectedIcon: Icon(Icons.account_tree)),
        ],
      ),
    );
  }
}
