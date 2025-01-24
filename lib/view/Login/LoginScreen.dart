import 'package:Tourism_app/view/Login/RegisterScreen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                          text: 'Login',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );
                                // Proceed after successful login
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  showCustomSnackbar(
                                      context,
                                      ContentType.failure,
                                      'Error',
                                      'No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  showCustomSnackbar(
                                      context,
                                      ContentType.failure,
                                      'Error',
                                      'Wrong password provided.');
                                } else if (e.code == 'network-request-failed') {
                                  showCustomSnackbar(
                                      context,
                                      ContentType.failure,
                                      'Error',
                                      'Network error occurred.');
                                } else if (e.code == 'too-many-requests') {
                                  showCustomSnackbar(
                                      context,
                                      ContentType.failure,
                                      'Error',
                                      'Too many requests. Please try again later.');
                                } else {
                                  showCustomSnackbar(
                                      context,
                                      ContentType.failure,
                                      'Error',
                                      e.message ?? 'An unknown error occurred');
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

  void showCustomSnackbar(BuildContext context, ContentType messageType,
      String title, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            messageType == ContentType.success ? Icons.check : Icons.error,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor:
          messageType == ContentType.success ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
