import 'package:flutter/material.dart';
import 'package:my_first_ecommerce_app/constants.dart';
import 'package:my_first_ecommerce_app/my_custom_widgets/custom_text_field.dart';
import 'package:my_first_ecommerce_app/providers/loginloading.dart';
import 'package:my_first_ecommerce_app/screens/home_screen.dart';
import 'package:my_first_ecommerce_app/screens/login_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_first_ecommerce_app/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignUpScreen();
  }
}

class SignUpScreen extends StatelessWidget {
  static String id = "signUpScreen";
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password, _name;
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final modelHud = Provider.of<MyModelHud>(context);
    print(">>>>>>>>>> " + modelHud.isLoading.toString());
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
                      _name = value;
                    },
                    prefixIcon: Icons.person,
                    label: "Full Name",
                    hint: "Type Your Full Name",
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
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
                      onPressed: () async {
                        final modelHud =
                            Provider.of<MyModelHud>(context, listen: false);

                        if (_formKey.currentState.validate()) {
                          modelHud.checkIsLoaing(true);
                          print("---------- before sign" +
                              modelHud.isLoading.toString());

                          _formKey.currentState.save();

                          try {
                            await _auth.signUp(_email.trim(), _password.trim());
                            modelHud.checkIsLoaing(false);
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.id);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.message,
                                ),
                              ),
                            );
                          }
                        }
                        modelHud.checkIsLoaing(false);
                      },
                      child: Text(
                        "Sign Up",
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
                        "I have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
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
}
