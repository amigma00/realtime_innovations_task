import 'package:flutter/material.dart';
import 'package:realtime_innovations_task/src/constants/app_colors.dart';
import 'package:realtime_innovations_task/src/core/extension/padding_extension.dart';

class RealInnovTexTField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  const RealInnovTexTField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.readOnly,
    this.suffixIcon,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      onTap: onTap,
      readOnly: readOnly ?? false,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      decoration: InputDecoration(
        // error: SizedBox.shrink(),
        // errorText: '',

        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorName.textFieldHint,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.zero,
        prefixIcon:
            prefixIcon?.paddingOnly(top: 8, bottom: 8, left: 8, right: 12),
        prefixIconConstraints: BoxConstraints(
          minHeight: 40,
          minWidth: 24,
        ),
        suffixIcon:
            suffixIcon?.paddingOnly(top: 8, bottom: 8, left: 12, right: 8),
        suffixIconConstraints: BoxConstraints(
          minHeight: 40,
          minWidth: 24,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: ColorName.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: ColorName.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: ColorName.primary,
          ),
        ),
      ),
    );
  }
}
