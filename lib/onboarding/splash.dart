// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:admin_dormsync/license/license_list.dart';
import 'package:admin_dormsync/onboarding/login.dart';
import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/components/prefences.dart';
import 'package:admin_dormsync/utils/images.dart';
import 'package:admin_dormsync/utils/navigations.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:admin_dormsync/utils/textstyle.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StyleText textstyles = StyleText();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Preference.getBool(PrefKeys.userstatus) == false
          ? pushNdRemove(const LoginScreen())
          : pushNdRemove(const LicenseViewScreen());
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Sizes.height,
        width: Sizes.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffD3D604).withValues(alpha: .35),
              Color(0xff3AB60C).withValues(alpha: .35),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(Images.loginMain, height: Sizes.height * .2),
            ),

            SizedBox(height: Sizes.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dorm',
                  style: textstyles.merriweatherText(
                    30,
                    FontWeight.w500,
                    AppColor.primary2,
                  ),
                ),
                Text(
                  "Sync",
                  style: textstyles.merriweatherText(
                    30,
                    FontWeight.w500,
                    AppColor.primary,
                  ),
                ),

                Image.asset(Images.logoadd, height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
