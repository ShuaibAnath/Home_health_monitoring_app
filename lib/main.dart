import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/doctor_home_page.dart';
import 'package:home_health_monitoring_app/patient_details_page.dart';
import 'package:home_health_monitoring_app/register_page.dart';
import 'package:home_health_monitoring_app/login_page.dart';
import 'package:home_health_monitoring_app/root.dart';
import 'package:home_health_monitoring_app/utils.dart';
import 'package:home_health_monitoring_app/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

const bool useEmulator = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if(useEmulator) await _connectToFirebaseEmulator();
  runApp(const MyApp());
}


 Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  await FirebaseAuth.instance.useAuthEmulator(localHostString, 9099);
  debugPrint('Using firebase Firestore emulator on : $localHostString:8080');
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: Utils.messengerKey,
      initialRoute: Root.id,
      routes: {
        Root.id: (context) => const Root(),
        WelcomePage.id: (context) => const WelcomePage(),
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        DoctorHomePage.id: (context) => const DoctorHomePage(),
        PatientDetailsPage.id: (context) => const PatientDetailsPage(),
      },
    );
  }
}
