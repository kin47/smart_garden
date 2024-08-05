import 'package:flutter/material.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  final bool value;
  final bool? iconRadio;
  final Function() onChange;

  const CustomCheckBoxWidget(
      {Key? key, this.iconRadio, required this.value, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange();
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: value
            ? Icon(
                (iconRadio ?? false)
                    ? Icons.radio_button_checked_sharp
                    : Icons.check_circle,
                size: 24,
                // color: AppColors.secondary1,
              )
            : const Icon(
                Icons.radio_button_unchecked,
                size: 24,
                // color: AppColors.gray3,
              ),
      ),
    );
  }
}
