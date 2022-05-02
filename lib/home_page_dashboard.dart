import 'dart:math';
// import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/patient_details_page.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';

class HomePageDashboard extends StatefulWidget {
  const HomePageDashboard({Key? key}) : super(key: key);
  static const String id = 'doctor_home_page';
  @override
  State<HomePageDashboard> createState() => _HomePageDashboardState();
}

class _HomePageDashboardState extends State<HomePageDashboard> {
  final items = List.generate(5, (counter) => '${Random().nextInt(4) + 1}');

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser;
    //final functions = FirebaseFunctions.instance;
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.05),
        Padding(
          padding: EdgeInsets.fromLTRB(
              SizeConfig.screenWidth * 0.05,
              0,
              SizeConfig.screenWidth * 0.05,
              SizeConfig.screenHeight * 0.01),
          child: const Text(
            'Below is the list of patients that you have accepted: ',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
              child: buildListView(),
              height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth * 0.8,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.05),
      ],
    );
  }

  Widget buildListView() {
    List<String> patientList = List.generate(5, (number) => 'Patient ${number + 1}');
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

//TODO: drop down with hospitals and request hospital code and MAKE SCROLLABLE
