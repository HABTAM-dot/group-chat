import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/servics/auth_service.dart';
import 'package:ecommerce/servics/database_service.dart';
import 'package:ecommerce/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/helper_function.dart';
import '../pages/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isloading = false;
  Authservice authservice = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            ):SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Group',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'login now to see what  they are taking',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Image.asset('assets/login.png'),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputDecoration.copyWith(
                        labelText: 'email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        )),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      return  RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value!)
                          ? null
                          : 'please enter a valid email';
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                        labelText: 'password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                        )),
                    validator: (val) {
                      if (val!.length < 6) {
                        return 'password must be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(
                        'sign in',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        login();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text.rich(TextSpan(
                      text: "don't have an account?",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Register here',
                            style: TextStyle(
                                color: Color.fromARGB(255, 236, 71, 126),
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                nextScreen(context, RegisterPage());
                              })
                      ]))
                ],
              ),
            )),
      ),
    );
  }

  login()async {
    if (formKey.currentState!.validate()) {
   
      setState(() {
        _isloading = true;
      });
      await authservice.signInUserWithEmailandPassword( email, password)
          .then((value) async {
        if (value == true) {
        QuerySnapshot snapshot= await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getingUserData(email);
         
          await HelperFunction.saveuserlogstatus(true);
          await HelperFunction.saveuseremail(email);
          await HelperFunction.saveusername(snapshot.docs[0]['fullName']); 
          nextScreenReplacement(context, HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isloading = false;
          });
        }
      });
    }
    }
  }
