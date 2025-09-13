import 'dart:developer';

import 'package:admin_dormsync/license/license_list.dart';
import 'package:admin_dormsync/utils/buttons.dart';
import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/components/api.dart';
import 'package:admin_dormsync/utils/components/prefences.dart';
import 'package:admin_dormsync/utils/images.dart';
import 'package:admin_dormsync/utils/navigations.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:admin_dormsync/utils/snackbar.dart';
import 'package:admin_dormsync/utils/textfield.dart';
import 'package:admin_dormsync/utils/textstyle.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool saveLogin = false; // Checkbox state
  StyleText textstyles = StyleText();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Sizes.height,
        width: Sizes.width,
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width * .04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (Sizes.width > 850)
                Container(
                  height: Sizes.height,
                  width: Sizes.width * .45,
                  color: AppColor.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      SizedBox(height: Sizes.height * .03),
                      Image.asset(Images.loginMain, height: 400),
                      SizedBox(height: Sizes.height * .03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'From Rooms to Reports  ',
                            style: textstyles
                                .merriweatherText(
                                  20,
                                  FontWeight.w700,
                                  AppColor.primary2,
                                )
                                .copyWith(fontStyle: FontStyle.italic),
                          ),
                          Image.asset(Images.sync, height: 30),
                          Text(
                            '  All in Sync',
                            style: textstyles
                                .merriweatherText(
                                  20,
                                  FontWeight.w700,
                                  AppColor.primary,
                                )
                                .copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              SizedBox(
                height: Sizes.height,
                width: Sizes.width < 850 ? Sizes.width * .9 : Sizes.width * .35,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Sizes.height * .02,
                      horizontal: Sizes.width * .04,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: Sizes.height * .03),
                        if (Sizes.width <= 850)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dorm',
                                style: textstyles.merriweatherText(
                                  25,
                                  FontWeight.w500,
                                  AppColor.primary2,
                                ),
                              ),
                              Text(
                                "Sync",
                                style: textstyles.merriweatherText(
                                  25,
                                  FontWeight.w500,
                                  AppColor.primary,
                                ),
                              ),
                              Image.asset(Images.logoadd, height: 35),
                            ],
                          ),
                        SizedBox(height: Sizes.height * 0.06),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primary),
                            borderRadius: BorderRadius.circular(55),
                          ),
                          child: Text(
                            "Super Admin",
                            style: textstyles.merriweatherText(
                              18,
                              FontWeight.w800,
                              AppColor.black,
                            ),
                          ),
                        ),
                        SizedBox(height: Sizes.height * 0.05),
                        CommonTextField(
                          controller: userIdController,
                          image: Images.user,
                          hintText: 'Username',
                        ),
                        SizedBox(height: Sizes.height * 0.03),

                        CommonTextField(
                          controller: passwordController,
                          image: Images.lock,
                          hintText: 'Password',
                        ),
                        SizedBox(height: Sizes.height * 0.03),
                        Row(
                          children: [
                            SizedBox(width: 42),
                            Checkbox(
                              activeColor: AppColor.primary,
                              value: saveLogin,
                              side: BorderSide(color: AppColor.primary),
                              onChanged: (bool? value) {
                                setState(() {
                                  saveLogin = value!;
                                });
                              },
                            ),
                            Text(
                              "Remember me",
                              style: textstyles.merriweatherText(
                                15,
                                FontWeight.w600,
                                AppColor.lightblack,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Sizes.height * 0.03),
                        DefaultButton(
                          onTap: () {
                            postLogin();
                          },

                          hight: 50,
                          width: Sizes.width < 850 ? Sizes.width * .5 : 200,
                          text: 'Sign In',
                        ),
                        SizedBox(height: Sizes.height * 0.05),
                        Text(
                          "By Modern Software Technologies Pvt Ltd.",
                          textAlign: TextAlign.center,
                          style: textstyles.abhayaLibreText(
                            Sizes.width > 850 ? 19 : 17,
                            FontWeight.w800,
                            AppColor.lightblack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future postLogin() async {
    var response = await ApiService.postData('login', {
      'username': userIdController.text.trim().toString(),
      'password': passwordController.text.trim().toString(),
    });
    log(response.toString());
    if (response["status"] == true) {
      Preference.setBool(PrefKeys.userstatus, saveLogin);
      Preference.setString(PrefKeys.token, response['token']);
      showCustomSnackbarSuccess(context, response['message']);
      pushNdRemove(LicenseViewScreen());
    } else {
      showCustomSnackbarError(context, response['message']);
    }
  }
}
