import 'package:flutter/material.dart';

class LatexFormInput extends StatelessWidget {
  const LatexFormInput({
    super.key,
    required this.hintText,
    required this.onSaved,
  });
  final String hintText;
  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty || value.trim().length <= 1) {
            return "Input must more than one char";
          }
          return null;
        },
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
