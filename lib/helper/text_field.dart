import 'package:flutter/material.dart';
import 'package:getx_flutter/constants/Constant.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final IconData? icon;
  final IconData? suffixIcon;
  final double? borderRadius;
  final bool? isPassword;
  final TextInputAction? action;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onchange;
  final TextEditingController? controller;
  final int? minLine;
  final Color? hintColor;
  final Color? textColor;
  final Color? labelColor;
  final bool? isReadOnly;
  final Function? onSuffixIconTap;
  final double? verticalSpacing;

  CustomTextField({
    this.hint,
    this.label,
    this.keyboardType,
    this.icon,
    this.suffixIcon,
    this.obscureText = false,
    this.borderRadius,
    this.action = TextInputAction.next,
    this.isPassword = false,
    this.validator,
    this.onSaved,
    this.onchange,
    this.controller,
    this.minLine,
    this.hintColor = blackTextColor,
    this.textColor = whiteColor,
    this.labelColor,
    this.isReadOnly = false,
    this.onSuffixIconTap = suffixClick,
    this.verticalSpacing = 0,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

void suffixClick() {}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPassToggle = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      focusNode: focusNode,
      obscureText: widget.isPassword! ? !isPassToggle : false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      cursorColor: whiteColor,
      textInputAction: widget.action,
      minLines: widget.minLine,
      maxLines: widget.minLine ?? 1,
      readOnly: widget.isReadOnly!,
      style: TextStyle(
        color: widget.textColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: grayBgColor,
        hintText: widget.hint,
        hintStyle: TextStyle(color: widget.hintColor),
        labelText: widget.label,
        labelStyle: TextStyle(color: grayBgColor),
        contentPadding: EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 30,
          ),
          borderSide: BorderSide(color: grayBgColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 30,
          ),
          borderSide: BorderSide(color: grayBgColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? 30,
          ),
          borderSide: BorderSide(color: grayBgColor),
        ),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onchange,
    );
  }
}
