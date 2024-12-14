import 'package:chat_app/conetants.dart';
import 'package:chat_app/helper/showSnackBar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormFeild(
                  hint: 'Email',
                  onChange: (data) {
                    email = data;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFeild(
                    hint: 'Password',
                    onChange: (data) {
                      password = data;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        //showSnackBar(context, 'Registration successful!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatPage(email: email!,)),
                        );
                      } on FirebaseAuthException catch (e) {
                        String errorMessage = '';
                        switch (e.code) {
                          case 'email-already-in-use':
                            errorMessage = 'This email is already in use.';
                            break;
                          case 'weak-password':
                            errorMessage = 'The password is too weak.';
                            break;
                          case 'invalid-email':
                            errorMessage = 'The email address is invalid.';
                            break;
                          default:
                            errorMessage =
                                'An unexpected error occurred. Please try again.';
                        }
                        showSnackBar(context, errorMessage);
                      } catch (e) {
                        showSnackBar(context, 'There was an error.');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account ? ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Color.fromARGB(255, 193, 220, 243),
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
