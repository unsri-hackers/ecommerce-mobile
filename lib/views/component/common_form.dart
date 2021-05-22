import 'package:flutter/material.dart';

class CTextFormFilled extends StatelessWidget {
  final String? hintText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  const CTextFormFilled({Key? key, this.hintText, this.onSaved, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText, border: OutlineInputBorder()),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
