import 'package:flutter/material.dart';

class TextFormBoxed extends StatelessWidget {
  final String? hintText;
  final TextEditingController? inputController;
  final String? initialValue;
  final void Function(String) onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? title;
  final bool isShowTitle;
  final int maxLines;
  final String? Function(String?)? validator;

  TextFormBoxed({
    this.hintText,
    this.inputController,
    this.initialValue,
    required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.hintStyle,
    this.obscureText = false,
    this.textInputType,
    this.title,
    this.isShowTitle = true,
    this.maxLines = 4,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isShowTitle,
          child: Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 2),
              child: Text(
                title ?? '',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: TextFormField(
            controller: inputController,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            validator: validator != null
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return "$title can\'t be left blank";
                    }
                    if (validator != null) {
                      return validator!(value);
                    } else {
                      return null;
                    }
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
