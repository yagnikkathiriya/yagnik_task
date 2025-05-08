import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yagnik_task/common/common_text_widget.dart';
import 'package:yagnik_task/common/common_textfeild_widget.dart';
import 'package:yagnik_task/helper/color_helper.dart';
import 'package:yagnik_task/model/user_model.dart';
import 'package:yagnik_task/user_bloc/user_bloc.dart';
import 'package:yagnik_task/user_bloc/user_event.dart';

class EditUserScreen extends StatefulWidget {
  final User user;
  const EditUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
  }

  void _submit() {
    final updatedUser = User(
      id: widget.user.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      address: widget.user.address,
    );

    log("Updated user: ${updatedUser.name}, ${updatedUser.email}, ${updatedUser.phone}");

    context.read<UserBloc>().add(EditUser(updatedUser));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: CommonTextWidget(
          title: "Edit User",
          fontSize: 18,
          textColor: AppColor.blackColor,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColor.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CommonTextfeildWidget(
              headingTitle: "Name",
              hintText: "Enter your Name",
              controller: nameController,
            ),
            const SizedBox(height: 10),
            CommonTextfeildWidget(
              headingTitle: "Email",
              hintText: "Enter your Email",
              controller: emailController,
            ),
            const SizedBox(height: 10),
            CommonTextfeildWidget(
              headingTitle: "Mobile Number",
              hintText: "Enter your Mobile Number",
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            InkWell(
              onTap: _submit,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primaryColor,
                ),
                child: CommonTextWidget(
                  title: "Save Changes",
                  fontSize: 16,
                  textColor: AppColor.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
