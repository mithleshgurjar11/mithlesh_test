import 'package:demo/constants/color_resources.dart';
import 'package:demo/utils/styles.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

import 'custom_methods.dart';


class AuthTextFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final double borderRadius;
  final int? maxLines;
  final bool? obscureText;
  final bool hasError;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final void Function()? onTapSuffixIcon;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool hasBorder;
  final bool boxShadow;
  final enabled;
  final Color borderColor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;

  const AuthTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.borderRadius = 12,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    required this.focusNode,
    this.obscureText,
    this.onTapSuffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.hasError = false,
    this.hasBorder = false,
    this.boxShadow = false,
    this.enabled,
    this.maxLines,
    this.borderColor = ColorResources.borderColor,
    this.hintStyle,
    this.textStyle,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> with WidgetsBindingObserver {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    focusNode.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: ColorResources.whiteColor,
            boxShadow: widget.boxShadow
                ? [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(0, 4),
                color: ColorResources.blackColor.withOpacity(0.1),
              )
            ]
                : null,
            border: widget.hasBorder
                ? Border.all(
              color: widget.hasError
                  ? ColorResources.redColor
                  : widget.borderColor,
              width: 1,
            )
                : null,
          ),
          child: Focus(
            focusNode: widget.focusNode,
            child: TextFormField(
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: "*",
              cursorColor: ColorResources.borderColor,
              controller: widget.controller,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              enabled: widget.enabled,
              style: widget.textStyle ?? textMd.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorResources.blackColor
              ),
              maxLines: widget.maxLines ?? null,
              decoration: InputDecoration(
                contentPadding: customPadding(20),
                fillColor: ColorResources.whiteColor,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? textMd.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorResources.blackColor
                ),
                prefixIcon: widget.prefixIcon != null
                    ? buildPrefixIcon(widget.prefixIcon!)
                    : null,
                suffixIcon: widget.suffixIcon != null
                    ? buildSuffixIcon(widget.suffixIcon!,
                    onTap: widget.onTapSuffixIcon)
                    : null,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              validator: widget.validator,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              onFieldSubmitted: widget.onFieldSubmitted,
              inputFormatters:  widget.inputFormatters ?? null,
            ),
          ),
        ),
      ],
    );
  }


  Widget buildPrefixIcon(Widget widget, {void Function()? onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 1,
      padding: customPadding(11),
      child: widget,
    ),
  );

  Widget buildSuffixIcon(Widget widget, {void Function()? onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 1,
      padding: customPadding(9),
      child: widget,
    ),
  );

}