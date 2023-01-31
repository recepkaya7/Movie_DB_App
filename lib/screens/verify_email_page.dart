import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/auth_style.dart';
import 'package:movie_db_api/pages/home.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //user needs to be created before!
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerifictaionEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerifictaionEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      CoolAlert.show(
        context: context,
        //backgroundColor: Constants.kProfilColor,
        type: CoolAlertType.info,
        text: 'Check Your Email'.tr,
        loopAnimation: true,
        //confirmBtnColor: Constants.kProfilColor,
      );
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } on FirebaseAuthException catch (e) {
      CoolAlert.show(
        context: context,
        backgroundColor: Colors.red.shade300,
        type: CoolAlertType.error,
        text: e.message.toString(),
        loopAnimation: true,
        confirmBtnColor: Colors.red.shade300,
      );
      /* showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.message.toString()),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        },
      ); */
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const MyHomePage()
        : Scaffold(
            appBar: AppBar(
              title:  Text('Verify Email'.tr),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    'A verification email has been sent to your email.'.tr,
                    style: kHeadline,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      icon: const Icon(Icons.email, size: 32),
                      label:  Text(
                        'Resent Email'.tr,
                        style: const TextStyle(fontSize: 24),
                      ),
                      onPressed: canResendEmail ? sendVerifictaionEmail : null),
                  const SizedBox(height: 8),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child:  Text(
                      'Cancel'.tr,
                      style: const TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  )
                ],
              ),
            ),
          );
  }
}
