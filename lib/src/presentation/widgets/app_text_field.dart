import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.maxLines,
    this.textInputType,
    this.textInputAction,
    this.withBorder = true,
    this.autofocus = false,
    this.readOnly = false,
    this.textStyle,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onTapOutside,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool withBorder;
  final bool autofocus;
  final bool readOnly;
  final TextStyle? textStyle;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final void Function(PointerDownEvent event)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      autofocus: autofocus,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      onTapOutside: onTapOutside,
      readOnly: readOnly,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        label: label?.isNotEmpty ?? false ? Text(label!) : null,
        hintText: hint,
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
