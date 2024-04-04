import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class InputField extends StatelessWidget {
  final String? labelText;
  final bool multiline;
  final bool enabled;
  final bool isPassword;
  final bool isUsername;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onTap;
  final int? maxLength;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const InputField({
    Key? key,
    this.labelText,
    this.controller,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.keyboardType,
    this.multiline = false,
    this.textAlign = TextAlign.left,
    this.maxLength,
    this.isPassword = false,
    this.isUsername = false,
    this.enabled = true,
    required String initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        enabled: enabled,
        maxLength: maxLength,
        obscureText: isPassword,
        textAlign: textAlign,
        maxLines: multiline ? null : 1,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
            : null,
        onChanged: onChanged,
        onSubmitted: onSubmit,
        onTap: onTap,
        controller: controller,
        cursorColor: Colors.white,
        style: const TextStyle(
          height: 1.0,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.red, //Theme.of(context).primaryColor,
            ),
          ),
          fillColor: Colors.red, //Theme.of(context).primaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
