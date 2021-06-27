import 'package:deuvox/app/utils/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTextFormFilled extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool? isPassword;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  const CTextFormFilled(
      {Key? key,
      this.labelText,
      this.hintText,
      this.isPassword,
      this.maxLines = 1,
      this.onSaved,
      this.validator,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 4),
            child: Text(
              labelText!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        TextFormField(
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          obscureText: isPassword ?? false,
        ),
      ],
    );
  }
}

class CDropdownFormField extends StatelessWidget {
  final String? labelText;
  final List<String> items;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CDropdownFormField(
      {Key? key,
      this.labelText,
      required this.items,
      this.onSaved,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) Text(labelText!),
        FormField(
          builder: (FormFieldState state) {
            return DropdownButtonHideUnderline(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DropdownButton<String>(
                  value: items.first,
                  isDense: true,
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ));
          },
          onSaved: onSaved,
          validator: validator,
        )
      ],
    );
  }
}
