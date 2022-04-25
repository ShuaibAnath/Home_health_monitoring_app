import 'package:home_health_monitoring_app/register_page.dart';
import 'package:flutter/material.dart';
import 'screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String id = 'login_page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      'Log In',
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
                      () => print('Login pressed'),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockVertical * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), // createElevatedButton
                    SizedBox(height: SizeConfig.safeBlockVertical * 5),
                    Row(
                      children: <Widget>[
                        UIComponents.createTextButton(
                            Text(
                              'Sign Up?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockVertical * 2,
                              ),
                            ),
                            () => Navigator.popAndPushNamed(context, RegisterPage.id)
                        ), // sign up button
                        SizedBox(width: SizeConfig.safeBlockHorizontal * 30),
                        UIComponents.createTextButton(
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockVertical * 2,
                              ),
                            ),
                            () => print(
                                'forgot password pressed')) // forgot password button
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
