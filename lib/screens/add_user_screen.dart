import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yagnik_task/common/common_text_widget.dart';
import 'package:yagnik_task/common/common_textfeild_widget.dart';
import 'package:yagnik_task/helper/color_helper.dart';
import 'package:yagnik_task/model/user_model.dart';
import 'package:yagnik_task/user_bloc/user_bloc.dart';
import 'package:yagnik_task/user_bloc/user_event.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  void _submit() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
    );

    context.read<UserBloc>().add(AddUser(newUser));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: CommonTextWidget(
          title: "Add New User",
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
            ),
            const SizedBox(height: 10),
            CommonTextfeildWidget(
              headingTitle: "Address",
              hintText: "Enter your Address",
              controller: addressController,
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
