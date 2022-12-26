import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool isObsecure;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmited;

  const CustomFormField({
    Key? key,
    required this.title,
    this.controller,
    this.isObsecure = false,
    this.isShowTitle = true,
    this.keyboardType,
    this.onFieldSubmited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        if (isShowTitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          obscureText: isObsecure,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: !isShowTitle ? title : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onFieldSubmitted: onFieldSubmited,
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
