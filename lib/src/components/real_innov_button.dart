import 'package:flutter/material.dart';
import 'package:realtime_innovations_task/gen/colors.gen.dart';

class RealInnovButton extends StatelessWidget {
  final bool isDisabled;
  final String text;
  final double? width;
  final void Function() onPressed;
  const RealInnovButton({
    super.key,
    this.isDisabled = false,
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        style: ButtonStyle(
            padding:
                WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            backgroundColor: WidgetStateProperty.all(
                isDisabled ? ColorName.lightBlue : ColorName.primary)),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: !isDisabled ? Colors.white : null),
        ),
      ),
    );
  }
}
