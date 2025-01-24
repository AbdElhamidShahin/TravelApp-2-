import 'package:Tourism_app/view/Login/LoginScreen.dart';
import 'package:Tourism_app/view/screens/HomePage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Wedget/CustomTextFeild.dart';
import '../Wedget/Custom_button.dart';

class Registerscreen extends StatelessWidget {
  String? email, password;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    const emailRegex = "@gmail.com";

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Stack(
          children: [
            // الصورة الخلفية الثابتة
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // تعديل الشفافية هنا
                  BlendMode.darken,
                ),
                child: Image.asset(
                  'assets/travel/Images/gettyimages-95062687-612x612.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome!',
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                      const Text(
                        'Time to cook, let\'s SignIn',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Customtextfeild(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          } else if (value.length < 3) {
                            return 'Must be at least 6 chars';
                          }

                          return null;
                        },
                        hintText: 'Name',
                        lableText: 'Name',
                        onChanged: (data) => email = data,
                      ),
                      Customtextfeild(
                        validator: (value) {
                          if (RegExp(emailRegex).hasMatch(value!)) {
                          } else if (value.isEmpty) {
                            return "@gmail.com";
                          } else {
                            return "@gmail.com";
                          }
                          return null;
                        },
                        hintText: 'Email',
                        lableText: 'Email',
                        onChanged: (data) => email = data,
                      ),
                      Customtextfeild(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          } else if (value.length < 6) {
                            return 'Must be at least 6 chars';
                          }

                          return null;
                        },
                        hintText: 'PassWord',
                        lableText: 'PassWord',
                        onChanged: (data) {
                          password = data;
                        },
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.amber, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        height: 55,
                        child: CustomButton(
                          text: 'Sign up',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                 FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );

                                showCustomSnackbar(
                                    context,
                                    ContentType.success,
                                    'Registration successful',
                                    'Redirecting now');

                                await Future.delayed(Duration(seconds: 2));

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Loginscreen(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showCustomSnackbar(
                                      context,
                                      ContentType.failure,
                                      'Error',
                                      'Weak password');
                                } else if (e.code == 'email-already-in-use') {
                                  showCustomSnackbar(
                                      context,
                                      ContentType.failure,
                                      'Error',
                                      'Email already in use');
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'It\'s your first time here?',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Loginscreen()));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.amber),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomSnackbar(BuildContext context, ContentType messageType,
      String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: 50.0, // المسافة من أعلى الشاشة
              left: 20.0,
              right: 20.0,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    color: messageType == ContentType.success
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        messageType == ContentType.success
                            ? Icons.check
                            : Icons.error,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(
                              context); // إغلاق الرسالة عند الضغط على زر الإغلاق
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
