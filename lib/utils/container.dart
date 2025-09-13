// ignore_for_file: must_be_immutable

import 'package:admin_dormsync/utils/colors.dart';
import 'package:admin_dormsync/utils/sizes.dart';
import 'package:flutter/material.dart';

class ReuseContainer extends StatelessWidget {
  const ReuseContainer({
    super.key,
    required this.text,
    required this.child,
    this.child1,
    this.child2,
  });
  final String? text;
  final Widget? child;
  final Widget? child1;
  final Widget? child2;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColor.primary, AppColor.primary2]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: child1 ?? const SizedBox(width: 0, height: 0),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    text!,
                    // style: StyleText.white22.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: child2 ?? const SizedBox(width: 0, height: 0),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}


class ButtonContainer extends StatelessWidget {
  ButtonContainer({required this.image, required this.text, super.key});
  String image;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.height * .02),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.primary2,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 3,
            color: AppColor.grey,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            maxRadius: 16,
            backgroundColor: AppColor.white,
            child: Image.asset(image, height: 24),
          ),
          Text(
            "  $text  ",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }
}
