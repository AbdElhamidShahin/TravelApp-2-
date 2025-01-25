import 'package:Tourism_app/view/Login/RegisterScreen.dart';
import 'package:Tourism_app/view/screens/HomePage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../VeiwModel/helper/showCustomSnackbar.dart';
import '../Wedget/CustomTextFeild.dart';
import '../Wedget/Custom_button.dart';

class Loginscreen extends StatelessWidget {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    const emailRegex =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'; // Improved email regex

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // Adjust opacity
                  BlendMode.darken,
                ),
                child: Image.asset(
                  'assets/travel/Tourism/backGround.jpg',
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
                        'Time to cook, let\'s Login',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Customtextfeild(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(emailRegex).hasMatch(value)) {
                            return 'Please enter a valid email';
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
                            return 'Password must be at least 6 characters';
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
                          text: 'Login ',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                UserCredential user = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                        email: email!, password: password!);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage()), // تغيير HomePage إلى الصفحة الرئيسية الفعلية في تطبيقك
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
                                    builder: (context) => Registerscreen()),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(color: Colors.amber),
                            ),
                          ),
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
}
