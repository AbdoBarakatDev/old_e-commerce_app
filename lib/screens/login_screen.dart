import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_first_ecommerce_app/constants.dart';
import 'package:my_first_ecommerce_app/my_custom_widgets/custom_text_field.dart';
import 'package:my_first_ecommerce_app/providers/CheckUserType.dart';
import 'package:my_first_ecommerce_app/providers/loginloading.dart';
import 'file:///J:/FlutterFullProjects/my_first_ecommerce_app/lib/admin/admin_homeScreen.dart';
import 'package:my_first_ecommerce_app/screens/home_screen.dart';
import 'package:my_first_ecommerce_app/screens/signup_sreen.dart';
import 'package:my_first_ecommerce_app/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = "loginScreen";
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password;
  final adminPassword = "admin@1234";
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final modelHud = Provider.of<MyModelHud>(context);
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: modelHud.isLoading,
      child: Scaffold(
        backgroundColor: mainAppColor,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: ExactAssetImage("images/icons/icon_buy.png"),
                      // fit: BoxFit.fill,
                    ),
                    Positioned(
                        bottom: 0,
                        child: Text(
                          "Store App",
                          style:
                              TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    onClick: (value) {
                      _email = value;
                    },
                    prefixIcon: Icons.email,
                    label: "Email",
                    hint: "Type Your Email",
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextField(
                    onClick: (value) {
                      _password = value;
                    },
                    prefixIcon: Icons.lock,
                    label: "Password",
                    hint: "Type Your Password",
                    suffixIcon: Icons.visibility_off,
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Builder(
                    builder: (context) => FlatButton(
                      onPressed: () {
                        validateUser(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: height * .01,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, SignUpScreen.id);
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            "I\'m an Admin",
                            style: TextStyle(
                            color: Provider.of<CheckIsAdmin>(context).isAdmin
                                ? mainAppColor
                                : Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Provider.of<CheckIsAdmin>(context,listen: false).checkIsAdmin(true);
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            "I\'m a User",
                            style: TextStyle(
                            color: Provider.of<CheckIsAdmin>(context).isAdmin
                                ? Colors.white
                                : mainAppColor),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Provider.of<CheckIsAdmin>(context,listen: false)
                                .checkIsAdmin(false);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  validateUser(BuildContext context) async {
    final admin = Provider.of<CheckIsAdmin>(context, listen: false);
    final modeHud = Provider.of<MyModelHud>(context, listen: false);
    modeHud.checkIsLoaing(true);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (admin.isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signIn(_email.trim(), _password.trim());
            modeHud.checkIsLoaing(false);
            Navigator.pushReplacementNamed(context, AdminHomeScreen.id);
          } catch (e) {
            generateScaffold(context, e.message);
          }
        } else {
          generateScaffold(context, "Oops something went wrong!");
        }
      } else {
        try {
          await _auth.signIn(_email.trim(), _password.trim());
          modeHud.checkIsLoaing(false);
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        } catch (e) {
          generateScaffold(context, e.message);
        }
      }
    }
    modeHud.checkIsLoaing(false);
  }

  generateScaffold(BuildContext context, String s) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }
}
