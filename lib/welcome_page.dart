import 'package:home_health_monitoring_app/login_page.dart';
import 'package:home_health_monitoring_app/register_page.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/ui_components/styles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const String id = 'welcome_page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final userList = ['Patient', 'Doctor'];
  String dropdownValue = 'Patient';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
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
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //add logo and icon
                    SizedBox(
                        height: SizeConfig.safeBlockVertical * 20 ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockVertical * 5,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 5,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB((SizeConfig.safeBlockHorizontal * 4), 0, (SizeConfig.safeBlockHorizontal * 4), (SizeConfig.safeBlockHorizontal * 4)),
                      child: Text(
                        'Before we get started. Are you a PATIENT or a DOCTOR? select one below:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.safeBlockVertical * 2,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 8),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Styles.dropDownIconArrow(),
                      elevation: 16,
                      style: Styles.dropDownTextStyle(Colors.white),
                      dropdownColor: Colors.black,
                      underline: Styles.dropDownUnderline(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Patient', 'Doctor']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 8),
                    Container(
                      padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 10, 0, SizeConfig.safeBlockHorizontal * 10, 0),
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
                            () => Navigator.pushNamed(context, LoginPage.id),

                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical * 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 10, 0, SizeConfig.safeBlockHorizontal * 10, 0),
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
                            () => Navigator.pushNamed(context, RegisterPage.id),
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical * 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ), // createElevatedButton
                    ),
                  ],
                ),
              ),
        ),
    );
  }
}
