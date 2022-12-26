import 'package:bank_sha/bloc/user/user_bloc.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/view/pages/transfer/transfer_amount_page.dart';
import 'package:bank_sha/view/widgets/buttons.dart';
import 'package:bank_sha/view/widgets/forms.dart';
import 'package:bank_sha/view/widgets/transfer_recent_user_item.dart';
import 'package:bank_sha/view/widgets/transfer_result_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final usernameController = TextEditingController(text: '');
  UserModel? selectedUser;

  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    userBloc = context.read<UserBloc>()
      ..add(
        UserGetRecent(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "Search",
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          CustomFormField(
            title: "by username",
            isShowTitle: false,
            controller: usernameController,
            onFieldSubmited: (value) {
              if (value.isNotEmpty) {
                userBloc.add(
                  UserGetByUsermame(value),
                );
              } else {
                selectedUser = null;
                userBloc.add(UserGetRecent());
              }
              setState(() {});
            },
          ),
          usernameController.text.isEmpty
              ? buildRecentUser(context)
              : buildResult(context),
          const SizedBox(
            height: 50,
          )
        ],
      ),
      floatingActionButton: selectedUser != null
          ? Container(
              margin: EdgeInsets.all(24),
              child: CustomFilledButton(
                title: "Continue",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferAmountPage(
                        data: TransferFormModel(sendTo: selectedUser!.username),
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildRecentUser(context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Users',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess)
                return Column(
                  children: state.users.map(
                    (user) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransferAmountPage(
                                data: TransferFormModel(
                                  sendTo: user.username,
                                ),
                              ),
                            ),
                          );
                        },
                        child: TransferRecentUserItem(user: user),
                      );
                    },
                  ).toList(),
                );

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildResult(context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Result',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                return Center(
                  child: Wrap(
                    spacing: 17,
                    runSpacing: 17,
                    children: state.users.map(
                      (user) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedUser = user;
                            });
                          },
                          child: TransferResultUserItem(
                            user: user,
                            isSelected: user.id == selectedUser?.id,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
