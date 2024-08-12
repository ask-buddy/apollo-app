import 'package:flutter/material.dart';

import '../../Themes/Textstyle/AB_textstyle.dart';

class LeftTextBody extends StatelessWidget {
  const LeftTextBody({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text,
            style: ABTextstyle.body1.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
