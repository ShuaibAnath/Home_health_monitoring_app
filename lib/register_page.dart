import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:home_health_monitoring_app/utils.dart';
import 'doctor_home_page.dart';
import 'login_page.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String id = 'register_page';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
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
              child: Form(
                key: formKey,
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
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1.8),
                          prefixIcon:  const Icon(
                            Icons.email,
                            color: Color(0xFF5AC18E),
                          ),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) => (email != null && !EmailValidator.validate(email)) ? 'Please enter a valid email' : null,
                      ),
                        SizeConfig.safeBlockVertical * 10
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 4),
                    UIComponents.createTextField(
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1.8),
                          prefixIcon:  const Icon(
                            Icons.lock,
                            color: Color(0xFF5AC18E),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Colors.black38,
                            //TODO: add obscure text
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (password) => (password != null && password.length < 6) ? 'Please ensure your password is minimum 6 characters long' : null,
                      ),
                        SizeConfig.safeBlockVertical * 10
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
                          signUp, //create user action
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockVertical * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), // createElevatedButton
                    SizedBox(height: SizeConfig.safeBlockVertical * 5),
                    RichText(
                      text:  TextSpan(
                        style: const TextStyle(color: Colors.white),
                        text: 'Already have an account? ',
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =  () => Navigator.popAndPushNamed(context, LoginPage.id),
                            text: 'Log In',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    bool caughtError = false;
    if(!isValid) return;// if not valid do not sign up
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>  Center(child: CircularProgressIndicator()),
    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      caughtError = false;
    } on FirebaseAuthException catch (e) {
      print(e);//TODO: handle error with alert dialog box
      Utils.showSnackBar(e.message);
      caughtError = true;
    }//catch

    if(caughtError) {
      navigatorKey.currentState!.pop();
    }else{
      navigatorKey.currentState!.pushNamedAndRemoveUntil(DoctorHomePage.id, (route) => false);
    }

  }

}
