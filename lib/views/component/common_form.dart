import 'package:deuvox/app/config/themes.dart';
import 'package:deuvox/app/utils/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CFilledInputField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  const CFilledInputField(
      {Key? key, this.labelText, this.hintText,this.maxLines=1, this.onSaved, this.validator, this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)   Container(
          margin: EdgeInsets.only(top: 10,bottom: 4),
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
          decoration:
          InputDecoration(hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )),
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}

class CGhostInputField extends StatelessWidget {
  final String? labelText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  const CGhostInputField(
      {Key? key, this.labelText, this.maxLines=1, this.onSaved, this.validator, this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)   Container(
          margin: EdgeInsets.only(left: 2, bottom: 4),
          child: Text(
            labelText!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        TextFormField(
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          decoration:
            InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
              border: UnderlineInputBorder(),
              isDense: true,
            ),
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
/*
class CDropdownFormField extends StatelessWidget {
  final String? labelText;
  final List<DropdownMenuItem<int>> items;
  final void Function(int?)? onSaved;
  final String? Function(int?)? validator;

  const CDropdownFormField(
    {Key? key, this.labelText, required this.items, this.onSaved, this.validator})
      : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)   Container(
          margin: EdgeInsets.only(left: 2),
          child: Text(
            labelText!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        DropdownButtonFormField(
          items: items,
          isDense: true,
          onTap: ,
          onSaved: onSaved,
          validator: validator,
        ),
      ],
    );
  }
}
*/
