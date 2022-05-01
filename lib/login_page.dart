//import 'package:home_health_monitoring_app/doctor_home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:home_health_monitoring_app/doctor_home_page.dart';
import 'package:home_health_monitoring_app/main.dart';
import 'package:home_health_monitoring_app/register_page.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/utils.dart';
import 'forgot_password_page.dart';
import 'screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String id = 'login_page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const DoctorHomePage();
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              } else {
                return Container(
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
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: SizeConfig.safeBlockVertical * 1.8),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xFF5AC18E),
                                ),
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            SizeConfig.safeBlockVertical * 10),
                        SizedBox(height: SizeConfig.safeBlockVertical * 3),
                        UIComponents.createTextField(
                            TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: SizeConfig.safeBlockVertical * 1.8),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF5AC18E),
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  color: Colors.black38,
                                  //TODO: add obscure text
                                ),
                              ),
                            ),
                            SizeConfig.safeBlockVertical * 10),
                        SizedBox(height: SizeConfig.safeBlockVertical * 4),
                        UIComponents.createElevatedButton(
                          TextButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            padding: EdgeInsets.all(
                                SizeConfig.safeBlockVertical * 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.safeBlockHorizontal * 3),
                            ),
                          ),
                          signIn,
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical * 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ), // createElevatedButton
                        SizedBox(height: SizeConfig.safeBlockVertical * 3),
                        GestureDetector(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.greenAccent,
                              fontSize: SizeConfig.safeBlockVertical * 2,
                            ),
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 5),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white),
                            text: 'No account? ',
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.popAndPushNamed(
                                      context, RegisterPage.id),
                                text: 'Sign Up',
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  Future signIn() async {
    bool caughtError = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      caughtError = false;
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      caughtError = true;
    } //catch

    if (caughtError) {
      navigatorKey.currentState!.pop();
    } else {
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(DoctorHomePage.id, (route) => false);
    }
  }
}
