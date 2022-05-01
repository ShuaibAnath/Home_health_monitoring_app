import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_health_monitoring_app/screen_dimensions.dart';
import 'package:home_health_monitoring_app/ui_components/buttons_and_textfields.dart';
import 'package:home_health_monitoring_app/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController =TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
          title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth * 0.05, SizeConfig.screenHeight * 0.05, SizeConfig.screenWidth * 0.05, SizeConfig.screenHeight * 0.05),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Enter your email below\nto receive and email to\nreset your password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 3,color: Colors.white),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
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
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              UIComponents.createElevatedButton(
                ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
                  primary: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        SizeConfig.safeBlockHorizontal * 3),
                  ),
                ),
                resetPassword, //create user action
                Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockVertical * 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async{

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>  Center(child: CircularProgressIndicator()),
    );
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password reset email has been sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch(e){
      print(e);
      Navigator.of(context).pop();
      Utils.showSnackBar(e.message);
    }

  }
}

