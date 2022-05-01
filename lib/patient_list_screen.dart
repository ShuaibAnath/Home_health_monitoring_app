import 'package:flutter/material.dart';
import 'dart:math';
import 'package:home_health_monitoring_app/patient_details_page.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final items = List.generate(70, (counter) => '${Random().nextInt(5) + 1}');

  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  Widget buildListView() {
    List<String> patientList = List.generate(70, (number) => 'Patient ${number + 1}');
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.transparent,
        thickness: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        items.sort();
        final hsiIndicator = items[index];
        var patient = patientList[index];
        return ListTile(
            tileColor: Colors.cyanAccent,
            title: Text(
              'Health state value =  $hsiIndicator',
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Text(
              patient,
              style: const TextStyle(
                  color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () => Navigator.pushNamed(context, PatientDetailsPage.id),
        );
      },
    );
  }
}

