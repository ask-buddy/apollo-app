import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';

class ABFormDivider extends StatelessWidget {
  const ABFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Divider(
            color: ABColors.white,
            thickness: 0.5,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style:
              const TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
        ),
        const Flexible(
          child: Divider(
            color: ABColors.white,
            thickness: 0.5,
            indent: 5,
          ),
        )
      ],
    );
  }
}
