import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/auth_style.dart';
import 'package:movie_db_api/main.dart';
import 'package:movie_db_api/screens/screen.dart';
import 'package:movie_db_api/widgets/widget.dart';

import '../main.dart';
import '../pages/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    registerEmailController.dispose();
    registerPasswordController.dispose();
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
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "Register".tr,
                              style: kHeadline,
                            ),
                             Text(
                              "Create new account to get started".tr,
                              style: kBodyText2,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            MyTextField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                              controller: registerEmailController,
                            ),
                            MyPasswordField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: registerPasswordController,
                              isPasswordVisible: passwordVisibility,
                              onTap: () {
                                setState(
                                  () {
                                    passwordVisibility = !passwordVisibility;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return StreamBuilder<User?>(
                                        stream: FirebaseAuth.instance
                                            .authStateChanges(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return const MyHomePage();
                                          } else {
                                            return const SignInPage();
                                          }
                                        });
                                  },
                                ),
                              );
                            });
                          },
                          child: Text(
                            'Sign In'.tr,
                            style: kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Register'.tr,
                      onTap: createUserEmailAndPassword,
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createUserEmailAndPassword() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try {
      await MyApp.auth.createUserWithEmailAndPassword(
          email: registerEmailController.text.trim(),
          password: registerPasswordController.text.trim());
      CoolAlert.show(
        context: context,
        backgroundColor: Colors.green,
        type: CoolAlertType.success,
        text: 'Successfully registered. You can now login.'.tr,
        loopAnimation: true,
        onConfirmBtnTap: () async {
          MyApp.auth.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
          );
        },
        confirmBtnColor: Colors.green,
      );
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
