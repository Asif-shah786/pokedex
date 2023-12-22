import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.beginColor,
      required this.endColor,
      required this.textColor,
      this.onPressed});

  final String text;
  final Color beginColor, endColor, textColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Theme.of(context).primaryColor.withAlpha(50),
          spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(2,2),
          )
        ],
        gradient: LinearGradient(
          colors: [beginColor, endColor],
        )
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: Colors.transparent,
          elevation: 0,
          fixedSize: const Size(200, 40),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
