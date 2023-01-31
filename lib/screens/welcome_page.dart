import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/auth_style.dart';
import 'package:movie_db_api/screens/verify_email_page.dart';
import 'package:movie_db_api/widgets/widget.dart';

import 'screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late bool status;

  @override
  Widget build(BuildContext context) {
    if (Get.locale!.languageCode == 'en') {
      status = true;
    } else {
      status = false;
    }
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const Center(
                      child: Image(
                        image:
                            AssetImage('assets/images/team_illustration.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome To \n MovieDb".tr,
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.shortestSide * 0.8,
                      child: Text(
                        "Welcome to the  my mobile app. Where you can find the most popular movies and TV series."
                            .tr,
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    /* AnimatedIconButton(
                      duration: const Duration(milliseconds: 500),
                      splashColor: Colors.transparent,
                      onPressed: () {
                        Get.updateLocale(Get.locale == const Locale('tr', 'TR')
                            ? const Locale('en', 'US')
                            : const Locale('tr', 'TR'));
                        Get.snackbar(
                            'Language Changed'.tr, 'Language ${Get.locale}'.tr);
                      },
                      icons: const <AnimatedIconItem>[
                        AnimatedIconItem(
                          icon: Icon(Icons.language, color: Colors.red),
                        ),
                        AnimatedIconItem(
                          icon: Icon(Icons.add, color: Colors.blue),
                        ),
                      ],
                    ), */
                    const SizedBox(
                      height: 5,
                    ),
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: Colors.blue.shade200,
                      inactiveToggleColor: Colors.red.shade200,
                      activeColor: Colors.blue.shade200,
                      inactiveColor: Colors.red.shade200,
                      activeIcon: Image.asset(
                        "assets/images/english.png",
                      ),
                      inactiveIcon: Image.asset(
                        "assets/images/turkey.png",
                      ),
                      onToggle: (val) {
                        setState(() {
                          status = val;

                          Get.updateLocale(
                              Get.locale == const Locale('tr', 'TR')
                                  ? const Locale('en', 'US')
                                  : const Locale('tr', 'TR'));
                          print(Get.locale!.languageCode);

                          Get.snackbar('Language Changed'.tr,
                              'Language ${Get.locale}'.tr);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextButton(
                          bgColor: Colors.transparent,
                          buttonName: 'Register'.tr,
                          onTap: () {
                            //RegisterPage();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                          },
                          textColor: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: MyTextButton(
                          bgColor: Colors.white,
                          buttonName: 'Sign In'.tr,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return StreamBuilder<User?>(
                                    stream: FirebaseAuth.instance
                                        .authStateChanges(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return const VerifyEmailPage();
                                      } else {
                                        return const SignInPage();
                                      }
                                    });
                              },
                            ));
                          },
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
