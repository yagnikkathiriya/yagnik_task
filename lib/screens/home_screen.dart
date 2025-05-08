// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yagnik_task/common/common_text_widget.dart';
import 'package:yagnik_task/helper/color_helper.dart';
import 'package:yagnik_task/model/user_model.dart';
import 'package:yagnik_task/screens/add_user_screen.dart';
import 'package:yagnik_task/screens/user_detail_screen.dart';
import 'package:yagnik_task/user_bloc/user_bloc.dart';
import 'package:yagnik_task/user_bloc/user_event.dart';
import 'package:yagnik_task/user_bloc/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _scrollController.addListener(_onScroll);
  }

  void _loadUsers() {
    context.read<UserBloc>().add(FetchUsers(page: currentPage));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage++;
      _loadUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: CommonTextWidget(
          title: "Users",
          fontSize: 18,
          textColor: AppColor.blackColor,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColor.whiteColor,
        actions: [
          InkWell(
            onTap: () async {
              final added = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddUserScreen()),
              );

              if (added == true) {
                currentPage = 1;
                context.read<UserBloc>().add(FetchUsers(page: currentPage));
              }
            },
            child: Container(
              height: 40,
              width: 100,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.primaryColor,
                ),
              ),
              child: CommonTextWidget(
                title: "Add User",
                fontSize: 15,
                textColor: AppColor.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final users = (state as dynamic).users as List<User>;
            return users.isEmpty
                ? CommonTextWidget(
                    title: "No User Found",
                    fontSize: 18,
                    textColor: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: users.length + 1,
                    // ignore:  body_might_complete_normally_nullable
                    itemBuilder: (context, index) {
                      if (index < users.length) {
                        final user = users[index];
                        return Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColor.primaryColor),
                          ),
                          child: ListTile(
                            title: CommonTextWidget(
                              title: user.name,
                              fontSize: 16,
                              textColor: AppColor.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            subtitle: CommonTextWidget(
                              title: user.email,
                              fontSize: 16,
                              textColor: AppColor.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      UserDetailScreen(userId: user.id),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
          } else if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _loadUsers,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
