import 'package:home_health_monitoring_app/register_page.dart';
import 'package:home_health_monitoring_app/login_page.dart';
import 'package:home_health_monitoring_app/welcome_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Material App',
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id: (context) => const WelcomePage(),
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
      },
    );
  }
}

//App gradient background

// class LsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       create: (context) => AuthBloc(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: RootScreen.id,
//         routes: {
//           RootScreen.id: (context) => RootScreen(),
//           WelcomeScreen.id: (context) => WelcomeScreen(),
//           LoginScreen.id: (context) => LoginScreen(),
//           RequiredInfoScreen.id: (context) => RequiredInfoScreen(userGmail: ''),
//           DummyScreen.id: (context) => DummyScreen(),
//           User_profile_screen.id: (context) => User_profile_screen(),
//           HomePage.id: (context) => HomePage(),
//         },
//       ),
//     );
//   }
// }