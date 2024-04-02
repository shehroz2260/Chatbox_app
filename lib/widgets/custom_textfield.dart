import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: AppTextStyle.circularFont14.copyWith(
              color: AppColors.greenColor, fontWeight: FontWeight.w500),
        ),
        TextFormField(
          style: AppTextStyle.carosFont16,
          controller: controller,
          onChanged: onChanged,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          cursorColor: Colors.black,
          decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.fieldBorderColor, width: 1)),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.fieldBorderColor, width: 1))),
        )
      ],
    );
  }
}
