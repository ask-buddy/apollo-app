import 'package:flutter/material.dart';
import '../../Themes/Textstyle/AB_textstyle.dart';

class TextFireClock extends StatelessWidget {
  const TextFireClock({
    super.key,
    required this.color,
    required this.text1,
    required this.icon1,
    required this.icon2,
    required this.text2,
  });
  final Color color;
  final IconData icon1;
  final IconData icon2;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon1,
          color: color,
          size: 22,
        ),
        const SizedBox(width: 6),
        Text(
          text1,
          style: ABTextstyle.body1Black.copyWith(color: color),
        ),
        const SizedBox(width: 12),
        Icon(
          icon2,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          text2,
          style: ABTextstyle.body1Black.copyWith(color: color),
        )
      ],
    );
  }
}
