import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management_setu/common/base_page.dart';
import 'package:task_management_setu/res/res.dart';

class CustomTextField extends StatefulWidget {
  final String? txtHint;
  final String? errorText;
  final String? initialValue;
  final TextEditingController? controller;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final bool? obscureText;
  final bool isHeading;
  final bool isReadOnly;
  final bool isSuffixIcon;
  final bool isPrefixIcon;
  final bool required;
  final String? textFieldHeading;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String?>? onChanged;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? suffixIconAction;
  final VoidCallback? prefixIconAction;
  final String? Function(String?)? validator;
  final bool isCustomPadding;
  final double? vPadding;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;

  const CustomTextField({
    super.key,
    this.txtHint,
    this.initialValue,
    this.controller,
    this.style,
    this.hintStyle,
    this.decoration,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconAction,
    this.prefixIconAction,
    this.validator,
    this.errorText,
    this.isHeading = false,
    this.textFieldHeading = 'Heading',
    this.isSuffixIcon = false,
    this.isPrefixIcon = false,
    this.isCustomPadding = false,
    this.vPadding = 20,
    this.inputFormatters,
    this.isReadOnly = false,
    this.required = false,
    this.onTap,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> with BasePageState {
  String asterisk = '*';
  TextStyle redAsteriskStyle =
      AppTextStyle.subTitle1M(txtColor: Colors.red, fSize: 16);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode
        ? AppColor.greyDarkest // Dark theme border color
        : AppColor.primary; // Light theme border color
    final fillColor = isDarkMode
        ? AppColor.primaryLightest // Dark theme fill color
        : AppColor.greyLight; // Light theme fill color
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.isHeading
            ? FittedBox(
                child: widget.required
                    ? Row(
                        children: [
                          Text(
                            widget.textFieldHeading!.toString(),
                            style: AppTextStyle.subTitle1M(
                                txtColor: isDarkMode
                                    ? AppColor
                                        .greyLightest // Dark theme border color
                                    : AppColor.greyDark,
                                fSize: 16),
                          ),
                          Text(
                            asterisk,
                            style: redAsteriskStyle,
                          ),
                        ],
                      )
                    : Text(
                        widget.textFieldHeading!.toString(),
                        style: AppTextStyle.subTitle1M(
                            txtColor: isDarkMode
                                ? AppColor
                                .greyLightest // Dark theme border color
                                : AppColor.greyDark, fSize: 16),
                      ),
              )
            : const SizedBox(),
        widget.isHeading ? vGap(height: 10) : const SizedBox(),
        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.isReadOnly,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          controller: widget.controller,
          style: widget.style,

          decoration: widget.decoration ??
              InputDecoration(
                errorText: widget.errorText,
                counterText: '',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: widget.isCustomPadding ? widget.vPadding! : 20,
                    horizontal: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                // filled: false,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColor.primary),
                ),
                fillColor: fillColor,
                hintText: widget.txtHint,
                hintStyle: widget.hintStyle,
              ),
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? false,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          // initialValue: widget.initialValue,
        ),
      ],
    );
  }
}
