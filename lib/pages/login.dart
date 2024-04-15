// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_local_variable

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app_project/pages/forgetPassword.dart';
import 'package:flower_app_project/pages/home.dart';
import 'package:flower_app_project/pages/regestar.dart';
import 'package:flower_app_project/provider/google_sign_in.dart';
import 'package:flower_app_project/shared/constant.dart';
import 'package:flower_app_project/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controllerEmail = TextEditingController();

  final controllerPassword = TextEditingController();
  bool isLoading = false;
  bool iconPasswordVisibilty = true;
  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controllerEmail.text, password: controllerPassword.text);
      showSnackBar(context, "Done ");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.code);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() { 
    // TODO: implement dispose
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarGreen,
          title: Text(
            "Sign In ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        validator: (value) {
                          return value != null &&
                                  !EmailValidator.validate(value)
                              ? "Enter a valid email"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter your Email :",
                            suffixIcon: Icon(Icons.email))),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        validator: (value) {
                          return value!.length < 8
                              ? "Enter at least 8 characters"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controllerPassword,
                        keyboardType: TextInputType.text,
                        obscureText: iconPasswordVisibilty,
                        decoration: decorationTextField.copyWith(
                            hintText: "Enter your Password :",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    iconPasswordVisibilty =
                                        !iconPasswordVisibilty;
                                  });
                                },
                                icon: iconPasswordVisibilty
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)))),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                          await signIn();
                        if (!mounted) return;

                  
                        //  showSnackBar(context, "Done... ");

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomePage(),
                        //     ));
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(BTNgreen),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),

                      //
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Sign in",
                              style: TextStyle(fontSize: 19),
                            ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton(

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomePage(),
                        //     ));
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPass(),
                              ));
                        },
                        child: Text(
                          "Forget password ",
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline),
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 27),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.green, width: 1)),
                              child: SvgPicture.asset(
                                "assets/icons8-facebook (1).svg",
                                height: 27,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 22,
                          ),
                          GestureDetector(
                            onTap: () {
                              googleSignInProvider.googlelogin();
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.green, width: 1)),
                              child: SvgPicture.asset(
                                "assets/icons8-google.svg",
                                height: 27,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 22,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.green, width: 1)),
                              child: SvgPicture.asset(
                                "assets/icons8-twitter.svg",
                                height: 27,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dont have an Account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ));
                            },
                            child: Text(
                              "Sign Up ",
                              style: TextStyle(
                                  fontSize: 17,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
