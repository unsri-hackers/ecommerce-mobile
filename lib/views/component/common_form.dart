import 'package:flutter/material.dart';

class CTextFormFilled extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLines;
  const CTextFormFilled(
      {Key? key, this.labelText, this.hintText,this.maxLines=1, this.onSaved, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) Text(labelText!),
        TextFormField(
          decoration:
              InputDecoration(hintText: hintText, border: OutlineInputBorder()),
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
