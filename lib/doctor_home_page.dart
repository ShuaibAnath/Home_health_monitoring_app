import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/patient_list_screen.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:home_health_monitoring_app/user_simple_preferences.dart';
import 'package:home_health_monitoring_app/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

//TODO: parse hospital names into dropdownButton
//TODO: send email to hospital
//TODO: update json file from server database
class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);
  static const String id = 'doctor_home_page';
  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  Map<String, dynamic> hospitalsEmails = {};
  String selectedHospitalEmail = '';
  @override
  void initState() {
    parseJsonFromAssets('hospitals/hospitals_emails.json').then((data) {
      hospitalsEmails = data;
    });
    setUserExists();
    super.initState();
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  } // function to get data from the json

  onChangedDropdownItem(String selectedHospital) {
    setState(() {
      selectedHospitalEmail = hospitalsEmails[selectedHospital];
    });
  }

  Future<bool> setUserExists() async {
    final prefs = await SharedPreferences.getInstance();
    final userRegistered =
        prefs.setBool(UserSimplePreferences.getIsUserSignedInKey(), true);
    return userRegistered;
  }

  int _currentIndex = 1;
  bool isHospitalConfirmed = false;
  List<String> hospitals = [
    'Albert Luthuli Hospital',
    'R.K.Khans Hospital',
    'Chatsmed Hospital'
  ];
  String? selectedItem;
  List<Widget> pages = [
    const PatientListScreen(),
    Text(
      'home',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.safeBlockHorizontal * 2,
        fontStyle: FontStyle.italic,
      ),
    ),
    Text(
      'profile',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.safeBlockHorizontal * 2,
        fontStyle: FontStyle.italic,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    //final functions = FirebaseFunctions.instance;
    const snackBar = SnackBar(
      content: Text(
        'Patients are ordered by ascending Health State Value(HSV), a lower HSV indicates higher priority.',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 8),
    );
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isHospitalConfirmed
              ? pages[_currentIndex]
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth * 0.05,
                          SizeConfig.screenHeight * 0.01,
                          SizeConfig.screenWidth * 0.05,
                          SizeConfig.screenHeight * 0.01),
                      child: const Text(
                        'Please select your hospital in the drop down menu below and request an access code to gain access to patient data',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth * 0.1,
                          SizeConfig.screenHeight * 0.01,
                          SizeConfig.screenWidth * 0.1,
                          0),
                      child: DropdownSearch<String>(
                        mode: Mode.DIALOG,
                        showSelectedItems: true,
                        showSearchBox: true,
                        items: hospitals,
                        dropdownSearchDecoration: const InputDecoration(
                          labelText: "Search for your hospital",
                          hintText: "Select your hospital",
                        ),
                        dropdownSearchBaseStyle:
                            const TextStyle(color: Colors.indigo),
                        popupBackgroundColor: Colors.cyanAccent,
                        onChanged: (selectedHospital) {
                          onChangedDropdownItem(selectedHospital!);
                        },
                        selectedItem: selectedItem,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth * 0.1,
                          SizeConfig.screenHeight * 0.01,
                          SizeConfig.screenWidth * 0.1,
                          0),
                      child: UIComponents.createElevatedButton(
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
                          'REQUEST CODE FROM HOSPITAL',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical * 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    UIComponents.createCustomWidget(
                      'Enter code received from your hospital',
                      Icons.admin_panel_settings_outlined,
                      EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 3, 0,
                          SizeConfig.safeBlockHorizontal * 3, 0),
                    ), // customWidget
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth * 0.1,
                          SizeConfig.screenHeight * 0.01,
                          SizeConfig.screenWidth * 0.1,
                          0),
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.thumb_up),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            padding: EdgeInsets.all(
                                SizeConfig.safeBlockVertical * 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.safeBlockHorizontal * 3),
                            ),
                          ),
                          label: Text(
                            'CONFIRM CODE',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical * 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isHospitalConfirmed = true;
                            });
                          }
                          ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth * 0.1,
                          SizeConfig.screenHeight * 0.01,
                          SizeConfig.screenWidth * 0.1,
                          0),
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_back),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            padding: EdgeInsets.all(
                                SizeConfig.safeBlockVertical * 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.safeBlockHorizontal * 3),
                            ),
                          ),
                          label: Text(
                            'SIGN OUT',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical * 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.popAndPushNamed(context, WelcomePage.id);
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool(
                                UserSimplePreferences.getIsUserSignedInKey(),
                                false);
                            FirebaseAuth.instance.signOut();
                          }),
                    ),
                    Text(user?.email ??
                        'No email detected, please sign out and retry'),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.cyan,
        animationDuration: const Duration(milliseconds: 500),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          if (newIndex == 0 && isHospitalConfirmed) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          setState(() {
            _currentIndex = newIndex;
          }); //setState
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.airline_seat_flat_angled_outlined),
              label: 'patient notifications',
              selectedIcon: Icon(Icons.airline_seat_flat_angled)),
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home)),
          NavigationDestination(
              icon: Icon(Icons.person_outlined),
              label: 'profile',
              selectedIcon: Icon(Icons.person)),
        ],
      ),
    );
  }

  Future<void> testFirestore() async {
    await FirebaseFirestore.instance
        .collection('test-collection')
        .doc()
        .set({'data': 'test'});
  }
}

//TODO: drop down with hospitals and request hospital code and MAKE SCROLLABLE
