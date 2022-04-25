import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String id = 'register_page';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff0b43ba),
                  Color(0xff0d7191),
                  Color(0xff0e8d7c),
                  Color(0xff01a37a),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 20,
                  horizontal: SizeConfig.safeBlockHorizontal * 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockVertical * 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 8),
                  UIComponents.createTextField(
                    'Email', //hintText
                    Icons.email, // fieldIcon
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  UIComponents.createTextField(
                    'Password', //hintText
                    Icons.lock, // fieldIcon
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
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
                        () => print('Register pressed'),
                    Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical * 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ), // createElevatedButton
                  SizedBox(height: SizeConfig.safeBlockVertical * 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
