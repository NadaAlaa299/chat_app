import 'package:chat_app/conetants.dart';
import 'package:chat_app/helper/showSnackBar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                      'Login',
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
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          //showSnackBar(context, 'Logedin successful!');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatPage(email: email!,)),
                          );
                        } on FirebaseAuthException catch (e) {
                          String errorMessage = '';
                          switch (e.code) {
                            case 'user-not-found':
                              errorMessage = 'No user found for that email.';
                              break;
                            case 'wrong-password':
                              errorMessage =
                                  'Wrong password provided for that user.';
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
                    }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account ? ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterPage();
                        }));
                      },
                      child: const Text(
                        'Register',
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

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
