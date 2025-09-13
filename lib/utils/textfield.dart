// ignore_for_file: must_be_immutable

import 'package:admin_dormsync/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField({
    required this.image,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onPressIcon,
    this.onTap,
    this.readOnly,
    this.focuesNode,
    this.suffixIcon,
    super.key,
  });
  String image;
  String? hintText;
  TextEditingController? controller;
  bool? readOnly;
  void Function(String)? onChanged;
  void Function()? onPressIcon;
  void Function()? onTap;
  FocusNode? focuesNode;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(onTap: onPressIcon, child: Image.asset(image, height: 30)),
        SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            focusNode: focuesNode,
            controller: controller,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly ?? false,
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(),
              hintText: hintText ?? "",
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                color: AppColor.black.withValues(alpha: .81),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}