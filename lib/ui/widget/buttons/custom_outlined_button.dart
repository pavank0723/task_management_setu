import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_setu/res/res.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String txt1;
  final String txt2;
  final void Function()? onPressed;
  final Color? borderColor;
  final double? borderRadius;
  final Color textColor;
  final bool isTwoText;
  final TextStyle? txt1Style;
  final TextStyle? txt2Style;

  const CustomOutlinedButton({
    super.key,
    this.txt1 = "Text 1",
    this.txt2 = "Text 2",
    this.txt1Style,
    this.txt2Style,
    required this.onPressed,
    this.borderColor = AppColor.primary,
    this.textColor = AppColor.primary,
    this.isTwoText = false,
    this.borderRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
          // border: Border.all(width: 2.w, color: (borderColor)!),
          borderRadius: BorderRadius.circular(borderRadius!).w),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor!),
          foregroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2.w, color: (borderColor)!),
            borderRadius: BorderRadius.circular(5).w, // Border radius
          ),
        ),
        child: isTwoText
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: txt1,
                      style: txt1Style,
                    ),
                    TextSpan(
                      text: txt2,
                      style: txt2Style,
                    )
                  ],
                ),
              )
            : FittedBox(
                child: Text(
                  txt1,
                  textAlign: TextAlign.center,
                  style: txt1Style ??
                      AppTextStyle.bodyM(
                        txtColor: textColor,
                      ),
                  maxLines: 1,
                ),
              ),
      ),
    );
  }
}
