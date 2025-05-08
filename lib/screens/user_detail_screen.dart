// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yagnik_task/common/common_text_widget.dart';
import 'package:yagnik_task/helper/color_helper.dart';
import 'package:yagnik_task/screens/edit_user_screen.dart';
import 'package:yagnik_task/user_bloc/user_bloc.dart';
import 'package:yagnik_task/user_bloc/user_event.dart';
import 'package:yagnik_task/user_bloc/user_state.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: CommonTextWidget(
          title: "User Details",
          fontSize: 18,
          textColor: AppColor.blackColor,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColor.whiteColor,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final user = state.users;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: user.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('👤 Name: ${user[index].name}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('📧 Email: ${user[index].email}',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('📞 Phone: ${user[index].phone}',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditUserScreen(user: user[index]),
                              ),
                            );
                            if (updated == true) {
                              context
                                  .read<UserBloc>()
                                  .add(FetchUsers(page: user[index].id));
                            }
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                  const Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No user data available"));
          }
        },
      ),
    );
  }
}
