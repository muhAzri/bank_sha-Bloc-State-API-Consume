import 'package:flutter/material.dart';

import '../../models/data_plan_model.dart';
import '../../shared/shared_methods.dart';
import '../../shared/theme.dart';

class DataPackageItem extends StatelessWidget {
  final DataPlanModel dataPlan;
  final bool isSelected;

  const DataPackageItem({
    Key? key,
    required this.dataPlan,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 175,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: isSelected ? blueColor : whiteColor, width: 2.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dataPlan.name.toString(),
            style: blackTextStyle.copyWith(
              fontSize: 32,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            formatCurrency(dataPlan.price!),
            style: greyTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
