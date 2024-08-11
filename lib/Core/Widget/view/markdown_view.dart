import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../Constants/htmlstyle.dart';

class MarkdownView extends StatelessWidget {
  const MarkdownView({
    super.key,
    required this.resultText,
  });

  final String resultText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: TeXView(
        renderingEngine: const TeXViewRenderingEngine.katex(),
        child: TeXViewDocument(
          ABStyle.mainStyle + resultText,
          style: const TeXViewStyle(contentColor: Colors.white),
        ),
      ),
    );
  }
}
