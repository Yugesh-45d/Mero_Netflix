import 'package:flutter/material.dart';
import 'package:netflix/components/buttons/app_button.dart';

class PrimaryShortButton extends StatelessWidget {
  const PrimaryShortButton({super.key, required this.text, required this.func});

  final String text;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    return AppButton(
      isFilled: true,
      text: text,
      height: mySize.height / 14,
      width: mySize.width / 2.2,
      func: func,
    );
  }
}
