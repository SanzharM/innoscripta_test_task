import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.maxLines,
    this.textInputType,
    this.withBorder = true,
  });

  final TextEditingController controller;
  final String? label;
  final int? maxLines;
  final TextInputType? textInputType;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: label?.isNotEmpty ?? false ? Text(label!) : null,
        border: withBorder ? null : InputBorder.none,
        focusedBorder: withBorder ? null : InputBorder.none,
        errorBorder: withBorder ? null : InputBorder.none,
        enabledBorder: withBorder ? null : InputBorder.none,
        disabledBorder: withBorder ? null : InputBorder.none,
        focusedErrorBorder: withBorder ? null : InputBorder.none,
      ),
    );
  }
}
