import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_setu/res/res.dart';


class CustomElevatedButton extends StatelessWidget {
  final String? text;

  // final TextStyle? labelStyle;
  final double? borderRadius;
  final Color? bgColor;
  final TextStyle? textStyle;
  final void Function()? onPressed;

  const CustomElevatedButton({
    super.key,
    this.text = 'submit',
    this.onPressed,
    this.bgColor = AppColor.primary,
    // this.labelStyle = AppTextStyle.bodyB(),
    this.borderRadius = 5,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius!.r).w, // Border radius
          ),
        ),
        child: FittedBox(
          child: Text(
            maxLines: 1,
            // UtilMethods.breakTextIntoTwoLines(text.toString(),1),
            text.toString(),
            style: AppTextStyle.bodyB(txtColor: AppColor.white, fSize: 13.sp),
          ),
        ),
      ),
    );
  }
}
