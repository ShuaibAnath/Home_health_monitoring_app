import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:home_health_monitoring_app/user_simple_preferences.dart';
import 'package:home_health_monitoring_app/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    SizeConfig().init(context);
    return Column(
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
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
               Text(
                'User email: ',
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.screenHeight * 0.03,
                ),
              ),
              Text(
                user?.email ?? 'No email',
                style:  TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.screenHeight * 0.03,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.05),
        Text(
          'Specialist Type: Physician',
          style:  TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.screenHeight * 0.03,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.05),
        Text(
          'Hospital: Albert Luthuli',
          style:  TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.screenHeight * 0.03,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.05),
        ElevatedButton.icon(
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
        SizedBox(height: SizeConfig.screenHeight * 0.05),
      ],
    );
  }
}
