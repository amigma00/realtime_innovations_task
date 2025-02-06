import 'package:flutter/material.dart';
import 'package:realtime_innovations_task/gen/colors.gen.dart';
import 'package:realtime_innovations_task/src/core/extension/padding_extension.dart';

class RealInnovTexTField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefix;
  const RealInnovTexTField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorName.textFieldHint,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.zero,
        prefixIcon: prefix?.paddingOnly(top: 8, bottom: 8, left: 8, right: 12),
        prefixIconConstraints: BoxConstraints(
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
      ),
    );
  }
}
