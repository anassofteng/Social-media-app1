// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    this.autoFocus = false,
    this.enable = true,
    required this.obscureText,
    required this.hint,
    required this.keyBoardType,
    required this.onValidator,
    required this.onFiledSubmittedValue,
    required this.focusnode,
    required this.myController,
  });

  final TextEditingController myController;
  final FocusNode focusnode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: myController,
        focusNode: focusnode,
        obscureText: obscureText,
        onFieldSubmitted: onFiledSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 19),
        decoration: InputDecoration(
          hintText: hint,
          enabled: enable,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppColors.primaryTextTextColor.withOpacity(0.8),
              height: 0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textFieldDefaultFocus,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.secondaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.alertColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textFieldDefaultBorderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }
}
