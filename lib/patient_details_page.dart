import 'dart:math';
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

  List<Widget> pages = [
    LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
              maxContentWidth: 100,
              tooltipBgColor: Colors.orange,
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
            axisNameWidget: Text(
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
        backgroundColor: Colors.black,
        titlesData: FlTitlesData(show: false),
        minX: 0,
        maxX: 21,
        minY: 40,
        maxY: 125,
        lineBarsData: [
          LineChartBarData(
            color: Colors.blueAccent,
            spots: List.generate(21,
                (index) => FlSpot(index.toDouble(), Random().nextInt(60) + 61)),
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
        backgroundColor: Colors.black,
        titlesData: FlTitlesData(show: false),
        minX: 0,
        maxX: 21,
        minY: 50,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            color: Colors.blueAccent,
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth * 0.1,
            SizeConfig.screenHeight * 0.15,
            SizeConfig.screenWidth * 0.1,
            SizeConfig.screenHeight * 0.1),
        child: Container(child: pages[_currentIndex]),
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
              label: 'O2 SATS',
              selectedIcon: Icon(Icons.account_tree)),
        ],
      ),
    );
  }
}
