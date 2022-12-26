import 'package:bank_sha/bloc/data_plan/data_plan_bloc.dart';
import 'package:bank_sha/models/data_plan_form_model.dart';
import 'package:bank_sha/models/data_plan_model.dart';
import 'package:bank_sha/view/widgets/data_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../models/operator_card_model.dart';
import '../../../shared/shared_methods.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';
import '../../widgets/forms.dart';

class DataPackagePage extends StatefulWidget {
  final OperatorCardModel operatorCard;

  const DataPackagePage({Key? key, required this.operatorCard})
      : super(key: key);

  @override
  State<DataPackagePage> createState() => _DataPackagePageState();
}

class _DataPackagePageState extends State<DataPackagePage> {
  final phoneController = TextEditingController(text: '');

  DataPlanModel? selectedDataPlan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPlanBloc(),
      child: BlocConsumer<DataPlanBloc, DataPlanState>(
        listener: (context, state) {
          if (state is DataPlanFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is DataPlanSuccess) {
            context.read<AuthBloc>().add(
                  AuthUpdateBalance(
                    selectedDataPlan!.price! * -1,
                  ),
                );

            Navigator.pushNamedAndRemoveUntil(
                context, '/data-success', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is DataPlanLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Paket Data',
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Phone Number",
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomFormField(
                  title: "+628",
                  isShowTitle: false,
                  controller: phoneController,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Select Package",
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Center(
                  child: Wrap(
                    spacing: 17,
                    runSpacing: 17,
                    children: widget.operatorCard.dataPlans!.map(
                      (dataPlan) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                selectedDataPlan = dataPlan;
                              },
                            );
                          },
                          child: DataPackageItem(
                            dataPlan: dataPlan,
                            isSelected: dataPlan.id == selectedDataPlan?.id,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
            floatingActionButton:
                (phoneController.text.isNotEmpty && selectedDataPlan != null)
                    ? Container(
                        margin: EdgeInsets.all(24),
                        child: CustomFilledButton(
                          title: "Continue",
                          onPressed: () async {
                            if (await Navigator.pushNamed(context, '/pin') ==
                                true) {
                              final authState = context.read<AuthBloc>().state;
                              String pin = '';
                              if (authState is AuthSuccess) {
                                pin = authState.user.pin!;
                              }

                              context.read<DataPlanBloc>().add(
                                    DataPlanPost(
                                      DataPlanFormModel(
                                        dataPlanid: selectedDataPlan!.id,
                                        phoneNumber: phoneController.text,
                                        pin: pin,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      )
                    : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
