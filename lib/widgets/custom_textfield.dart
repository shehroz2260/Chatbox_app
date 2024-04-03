import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  final String titleText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool isSearchField;
  final bool? filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final String? hintText;
  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.isSearchField = false,
    this.onChanged,
    this.keyboardType,
    this.filled,
    this.fillColor,
    this.prefixIcon,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSearchField)
          Text(
            titleText,
            style: AppTextStyle.circularFont14.copyWith(
                color: AppColors.greenColor, fontWeight: FontWeight.w500),
          ),
        TextFormField(
          keyboardType: keyboardType,
          style: AppTextStyle.carosFont16,
          controller: controller,
          onChanged: onChanged,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyle.circularFont12,
              prefixIcon: prefixIcon,
              filled: filled,
              fillColor: fillColor,
              focusedBorder: isSearchField
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          const BorderSide(color: AppColors.lightGreyColor))
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.fieldBorderColor, width: 1)),
              enabledBorder: isSearchField
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          const BorderSide(color: AppColors.lightGreyColor))
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.fieldBorderColor, width: 1))),
        )
      ],
    );
  }
}
