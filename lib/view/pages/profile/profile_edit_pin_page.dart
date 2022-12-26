import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/view/widgets/buttons.dart';
import 'package:bank_sha/view/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/shared_methods.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPinPage> createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {
  final oldPinController = TextEditingController(text: '');
  final newPinController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Pin",
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/profile-edit-success', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 22,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      title: "Old PIN",
                      controller: oldPinController,
                      isObsecure: true,
                    ),
                    CustomFormField(
                      title: "New PIN",
                      controller: newPinController,
                      isObsecure: true,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomFilledButton(
                      title: "Update Now",
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthUpdatePin(
                                  oldPinController.text, newPinController.text),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
