import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/screens/screen.dart';

import '../constants/auth_style.dart';
import '../widgets/my_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Text(
                                'Receive an email to reset your password'.tr,
                                style: kHeadline,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                hintText: 'Email',
                                inputType: TextInputType.text,
                                controller: emailController,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton.icon(
                                onPressed: resetPassword,
                                icon: const Icon(Icons.email_outlined),
                                label:  Text(
                                  'Reset Password'.tr,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        )));
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      CoolAlert.show(
        context: context,
        backgroundColor: Colors.green,
        type: CoolAlertType.success,
        text: 'Check Your Email'.tr,
        loopAnimation: true,
        onConfirmBtnTap: () async {
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
