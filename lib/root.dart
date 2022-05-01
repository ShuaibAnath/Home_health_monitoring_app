import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/doctor_home_page.dart';
import 'package:home_health_monitoring_app/user_simple_preferences.dart';
import 'package:home_health_monitoring_app/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  loggedIn,
  notLoggedIn,
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);
  static const id = 'root_page';
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late Widget returnValue;
  bool checkDone = false;

  @override
  void initState() {
    isUserRegistered().then((data) {

      if (data == true) {
        returnValue = const DoctorHomePage();
      } else {
        returnValue = const WelcomePage();
      }
      setState(() {
        checkDone = true;
      });
    });

    super.initState();

  } //init state to autoLogin


  Future<bool> isUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    final userRegistered = prefs.getBool(UserSimplePreferences.getIsUserSignedInKey()) ?? false;// check if isUserSignedIn == null, if so return false
    return userRegistered;
  } //is user registered

  @override
  Widget build(BuildContext context) {
    return checkDone
        ? returnValue
        : const Scaffold(body: SafeArea(child: CircularProgressIndicator()));
  }
}
