// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:yagnik_task/common/common_text_widget.dart';
import 'package:yagnik_task/helper/color_helper.dart';

class CommonTextfeildWidget extends StatelessWidget {
  String? hintText;
  String? headingTitle;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  TextEditingController? controller;
  bool? obscureText;
  CommonTextfeildWidget(
      {this.hintText,
      this.headingTitle,
      this.validator,
      this.keyboardType,
      this.controller,
      this.obscureText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingTitle != ""
            ? CommonTextWidget(
                title: headingTitle,
                textColor: AppColor.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
            : SizedBox(),
        SizedBox(height: 8),
        TextFormField(
          validator: validator,
          cursorColor: AppColor.blackColor,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColor.whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColor.greyColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColor.greyColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColor.primaryColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
