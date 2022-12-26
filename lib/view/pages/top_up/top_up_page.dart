import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/bloc/payment_method/payment_method_bloc.dart';
import 'package:bank_sha/models/top_up_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/view/pages/top_up/top_up_amount_page.dart';
import 'package:bank_sha/view/widgets/bank_item.dart';
import 'package:bank_sha/view/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/payment_method_model.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  PaymentMethodModel? selectedPaymentMethods;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          buildWallet(context),
          buildSelectBank(context),
        ],
      ),
      floatingActionButton: (selectedPaymentMethods != null)
          ? Container(
              margin: EdgeInsets.all(24),
              child: CustomFilledButton(
                title: "Continue",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpAmountPage(
                        data: TopUpFormModel(
                          paymentMethodCode: selectedPaymentMethods?.code,
                        ),
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

  Widget buildWallet(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          'Wallet',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return Row(
                children: [
                  Image.asset(
                    "assets/img_wallet.png",
                    width: 80,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.cardNumber!.replaceAllMapped(
                            RegExp(r".{4}"), (match) => "${match.group(0)} "),
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        state.user.name.toString(),
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ],
    );
  }

  Widget buildSelectBank(context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Bank',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocProvider(
            create: (context) => PaymentMethodBloc()..add(PaymentMethodGet()),
            child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodSuccess) {
                  return Column(
                    children: state.paymentMethods.map((paymentMethod) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethods = paymentMethod;
                          });
                        },
                        child: BankItem(
                          paymentMethod: paymentMethod,
                          isSelected:
                              paymentMethod.id == selectedPaymentMethods?.id,
                        ),
                      );
                    }).toList(),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
