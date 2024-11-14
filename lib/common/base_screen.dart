import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management_setu/common/common.dart';
import 'package:task_management_setu/res/res.dart';
import 'package:task_management_setu/ui/widget/widget.dart';

class BaseScreen extends StatefulWidget {
  final String title;
  final String txtFloatingBtn;
  final String action;
  final String? appBarCustomIcon;
  final String navigateTo;
  final String floatingIcon;
  final bool isSafeAreaOnTop;
  final bool isIcon;
  final bool isCustomSvgIcon;
  final bool resizeToAvoidBottomInset;
  final bool isFloatingBtn;
  final bool isCustomBottomFAB;
  final bool isFloatingBtnWithLabel;
  final bool isLinearShade;
  final bool isTabView;
  final bool applyScroll;
  final bool enableAppBar;
  final bool homeAppBar;
  final bool isAppShadowEffect;
  final bool isAction;
  final bool isSpacingApply;
  final bool isSafeArea;
  final double iconSize;

  final Widget body;
  final Widget? bottomNav;

  final Widget? bottomSheet;

  final Color appBarBGColor;
  final Color appBarOtherColor;
  final Color appBarTitleColor;
  final Color? bgColor;
  final Function()? onAction;
  final Function()? onPressed;
  final Function()? fabOnTap1;
  final Function()? fabOnTap2;
  final Function()? fabOnTap3;
  final Function(dynamic data)? navigationCallback;

  final Object? args;

  final VoidCallback? expandableFABonTap;

  const BaseScreen(
      {super.key,
      this.title = "",
      this.isIcon = false,
      this.applyScroll = true,
      this.enableAppBar = true,
      this.homeAppBar = false,
      this.isLinearShade = false,
      this.isTabView = false,
      this.isFloatingBtn = false,
      this.isFloatingBtnWithLabel = false,
      this.isAppShadowEffect = true,
      this.isAction = false,
      this.isSpacingApply = true,
      this.isSafeArea = false, //true
      this.onAction,
      required this.body,
      this.action = "",
      this.bottomNav,
      this.navigateTo = "",
      this.floatingIcon = "",
      this.navigationCallback,
      this.onPressed,
      this.args,
      this.txtFloatingBtn = "Add new",
      this.appBarCustomIcon,
      this.appBarBGColor = AppColor.white,
      this.appBarOtherColor = AppColor.primary,
      this.appBarTitleColor = AppColor.greyDarkest,
      this.bgColor = AppColor.white,
      this.isCustomSvgIcon = false,
      this.bottomSheet,
      this.isCustomBottomFAB = false,
      this.fabOnTap1,
      this.fabOnTap2,
      this.fabOnTap3,
      this.expandableFABonTap,
      this.resizeToAvoidBottomInset = false,
      this.isSafeAreaOnTop = true,
      this.iconSize = 25});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen>
    with BasePageState, SingleTickerProviderStateMixin {
  bool isInternetConnected = false;

  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sMobile = AppDimen.appSmallDevice;

    Widget scaffold = Scaffold(
      bottomSheet: widget.bottomSheet,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.enableAppBar
          ? PreferredSize(
              preferredSize:
                  Size.fromHeight((width <= sMobile) ? 60.0.h : 70.0.h),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CustomActionBar(
                  txtTitle: widget.title,
                  txtAction: widget.action,
                  onAction: widget.onAction,
                  isAppBottomShadow: widget.isAppShadowEffect,
                  isAction: widget.isAction,
                  customIcon: widget.appBarCustomIcon,
                  iconSize: widget.iconSize,
                  isIcon: widget.isIcon,
                  appBarBGColor: widget.appBarBGColor,
                  appBarTitleColor: widget.appBarTitleColor,
                  appBarOtherColor: widget.appBarOtherColor,
                  isCustomSvgIcon: widget.isCustomSvgIcon,
                ),
              ),
            )
          : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: widget.applyScroll
            ? ScrollConfiguration(
                behavior: NoGlowBehaviour(),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Container(
                    color: AppColor.greyLight.withOpacity(0.15),
                    padding: widget.isSpacingApply
                        ? const EdgeInsets.symmetric(
                            horizontal: AppDimen.appHorizontalSpacing)
                        : EdgeInsets.zero,
                    child: widget.body,
                  ),
                ),
              )
            : Container(
                color: AppColor.greyLight.withOpacity(0.15),
                padding: widget.isSpacingApply
                    ? const EdgeInsets.symmetric(
                        horizontal: AppDimen.appHorizontalSpacing,
                        vertical: AppDimen.appVerticalPadding)
                    : EdgeInsets.zero,
                child: widget.body,
              ),
      ),
      bottomNavigationBar: widget.bottomNav,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //changed
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: widget.isCustomBottomFAB
          ? Container(
              margin: const EdgeInsets.only(top: 0),
              height: 64.h,
              width: 64.h,
              child: FloatingActionButton(
                backgroundColor: AppColor.primary,
                elevation: 0,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3.w,
                    color: AppColor.greyLightest,
                  ),
                  borderRadius: BorderRadius.circular(100).w,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColor.greyLightest,
                ),
              ),
            )
          : Visibility(
              visible: widget.isFloatingBtn,
              child: widget.isFloatingBtnWithLabel
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          // Add your onPressed code here!
                          widget.onPressed ??
                              navigateTo(widget.navigateTo, args: widget.args)
                                  .then((value) =>
                                      widget.navigationCallback!(value));
                        },
                        label: Text(
                          widget.txtFloatingBtn,
                          style: AppTextStyle.subTitle2M(
                              txtColor: AppColor.greyLightest),
                        ),
                        icon: SvgPicture.asset(
                          widget.floatingIcon,
                          colorFilter: const ColorFilter.mode(
                              AppColor.greyLightest, BlendMode.srcIn),
                        ),
                        backgroundColor: AppColor.primary,
                      ),
                    )
                  : FloatingActionButton(
                      heroTag: const Text('Floating Button'),
                      onPressed: () {
                        // Add your onPressed code here!
                        widget.onPressed ??
                            navigateTo(widget.navigateTo, args: widget.args)
                                .then((value) =>
                                    widget.navigationCallback!(value));
                      },
                      tooltip: widget.txtFloatingBtn,
                      backgroundColor: AppColor.primary,
                      child: SvgPicture.asset(
                        widget.floatingIcon,
                        colorFilter: const ColorFilter.mode(
                            AppColor.greyLightest, BlendMode.srcIn),
                      ),
                    ),
            ),
    );
    return !widget.isSafeArea
        ? SafeArea(
            top: false,
            bottom: true,
            child: scaffold,
          )
        : SafeArea(
            top: true,
            bottom: true,
            child: scaffold,
          );
  }


}
