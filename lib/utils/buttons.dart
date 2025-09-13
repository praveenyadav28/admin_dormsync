import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/textstyle.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.text,
    required this.hight,
    required this.width,
    required this.onTap,
    super.key,
  });

  final double hight;
  final double width;
  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    StyleText textstyles = StyleText();
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: hight,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: textstyles.merriweatherText(
                18,
                FontWeight.w700,
                AppColor.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.child,
    required this.hight,
    required this.width,
    required this.onTap,
    super.key,
  });

  final double hight;
  final double width;
  final Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: hight,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primary, AppColor.primary2],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
