import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/auth_style.dart';
import 'package:movie_db_api/main.dart';
import 'package:movie_db_api/provider/google_sign_in.dart';
import 'package:movie_db_api/screens/screen.dart';
import 'package:movie_db_api/widgets/social_login_button.dart';
import 'package:movie_db_api/widgets/widget.dart';
import 'package:provider/provider.dart';

import 'forgot_password_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isPasswordVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "Welcome back.".tr,
                              style: kHeadline,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             Text(
                              "You've been missed!".tr,
                              style: kBodyText2,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            MyTextField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hintText: 'Email',
                              inputType: TextInputType.text,
                              controller: emailController,
                            ),
                            MyPasswordField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: passwordController,
                              isPasswordVisible: isPasswordVisible,
                              onTap: () {
                                setState(
                                  () {
                                    isPasswordVisible = !isPasswordVisible;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SocialLoginButton(
                      textColor: Colors.black,
                      butonText: 'Sign Up With Google'.tr,
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false,
                        );
                        provider.googleLogin();
                      },
                      butonColor: Colors.red.shade300,
                      butonIcon: Image.asset(
                        'assets/images/google.png',
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Forgot Password?'.tr,
                        style: kBodyText.copyWith(
                          color: Colors.green,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dont't have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            });
                          },
                          child: Text(
                            'Register'.tr,
                            style: kBodyText.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Sign In'.tr,
                      onTap: signIn,
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    try {
      await MyApp.auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      CoolAlert.show(
        context: context,
        backgroundColor: Colors.red.shade300,
        type: CoolAlertType.error,
        text: e.message.toString(),
        loopAnimation: true,
        confirmBtnColor: Colors.red.shade300,
      );
    }
  }

}
