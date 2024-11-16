import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management_setu/res/res.dart';

class CustomActionBar extends StatelessWidget {
  final String txtTitle;
  final String txtAction;
  final String? customIcon;
  final Function()? onBack;
  final Function()? onAction;
  final bool isAppBottomShadow;
  final bool isAction;
  final bool isCustomAction;
  final bool isCustomSvgIcon;
  final bool isIcon;
  final double iconSize;
  final Widget? customAction;

  const CustomActionBar({
    super.key,
    this.txtTitle = '',
    this.txtAction = '',
    this.customIcon,
    this.onBack,
    this.onAction,
    this.isAppBottomShadow = true,
    this.isAction = false,
    this.isCustomAction = false,
    this.isCustomSvgIcon = true,
    this.isIcon = false,
    this.iconSize = 25,
    this.customAction,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sMobile = AppDimen.appSmallDevice;
    // Extract colors from the current theme
    final Color appBarBGColor = Theme.of(context).appBarTheme.backgroundColor ?? Colors.white;
    final Color appBarTitleColor = Theme.of(context).textTheme.headlineLarge?.color ?? Colors.black;
    final Color appBarOtherColor = Theme.of(context).primaryColor;
    return isAppBottomShadow
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: AppDimen.appActionBarHeight,
            decoration: const BoxDecoration(
              color: AppColor.greyLightest,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppColor.greyBefore,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 0.5))
              ],
              // color: AppColor.greyLight
            ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            // margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Row(
                    children: [
                      Visibility(
                        visible: isIcon,
                        child: GestureDetector(
                          onTap: onBack ??
                              () {
                                Navigator.pop(
                                  context,
                                );
                              },
                          child: isIcon
                              ? GestureDetector(
                                  onTap: onBack ??
                                      () {
                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                  child: isCustomSvgIcon
                                      ? SvgPicture.asset(
                                          customIcon ?? "",
                                          width: iconSize,
                                          height: iconSize,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.arrow_back_ios,
                                          color: AppColor.greyDark,
                                        ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: (isIcon && isAction)
                            ? MediaQuery.of(context).size.width - 150
                            : (isIcon || isAction)
                                ? MediaQuery.of(context).size.width - 130
                                : MediaQuery.of(context).size.width - 30,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          txtTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.subTitle1M(
                            fSize: (width <= sMobile) ? 16 : 18,
                            txtColor: appBarTitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isAction,
                  child: GestureDetector(
                    onTap: () {
                      onAction!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        txtAction,
                        style: AppTextStyle.subTitle2M(
                          txtColor: appBarOtherColor,
                          fSize: (width <= sMobile) ? 14 : 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: AppDimen.appActionBarHeight,
            decoration: BoxDecoration(
              color: appBarBGColor,

              // color: AppColor.greyLight
            ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            // margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: isIcon,
                        child: GestureDetector(
                          onTap: onBack ??
                              () {
                                Navigator.pop(
                                  context,
                                );
                              },
                          child: isCustomSvgIcon
                              ? SvgPicture.asset(
                                  customIcon ?? "",
                                  width: iconSize + 5,
                                  height: iconSize + 5,
                                  fit: BoxFit.fill,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(
                                      left: AppDimen.appSpace10),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColor.greyDark,
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          txtTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.subTitle1M(
                              fSize: (width <= sMobile) ? 16 : 18,
                              txtColor: appBarTitleColor),
                        ),
                      ),
                    ],
                  ),
                ),
                isAction
                    ? isCustomAction
                        ? customAction ?? const Text('NA')
                        : GestureDetector(
                            onTap: () {
                              onAction!();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                txtAction,
                                style: AppTextStyle.subTitle2M(
                                  txtColor: appBarOtherColor,
                                  fSize: (width <= sMobile) ? 14 : 16,
                                ),
                              ),
                            ),
                          )
                    : const SizedBox(width: AppDimen.appSpace15 + 5),
              ],
            ),
          );
  }
}
