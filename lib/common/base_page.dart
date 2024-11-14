import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_management_setu/res/res.dart';
import 'package:task_management_setu/util/util.dart';

mixin BasePageState<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
  }

  Future navigateTo(String destination, {Object? args}) {
    return Navigator.pushNamed(context, destination, arguments: args);
  }

  Future<R?> navigateToWithReturnData<R>(String destination, {Object? args}) {
    return Navigator.pushNamed<R>(context, destination, arguments: args);
  }

  Future replaceWith(String destination, {dynamic args}) {
    return Navigator.pushReplacementNamed(context, destination,
        arguments: args);
  }

  void showToast(String msg, ToastType type) {
    UtilMethods.showToast(msg, type);
  }

  void setStatusBarColor(bool isSafeArea) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isSafeArea ? AppColor.appBgColor : Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColor.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColor.appBgColor,
    ));
  }

  Widget hDashDivider(
      {double height = 1, double width = 10.0, Color color = Colors.black}) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth) + 10).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(
            dashCount,
            (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColor.white,
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: AppTextStyle.bodyB(txtColor: AppColor.primary),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes',
                    style: AppTextStyle.bodyB(txtColor: AppColor.primary)),
              ),
            ],
          ),
        )) ??
        false;
  }

  void showValidPopup(
      {String? title = 'Validation Error', String? message = ''}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvoked: (v) {
            if (v) {
              return;
            }
          },
          child: AlertDialog(
            backgroundColor: AppColor.white,
            title: Text(title!),
            content: Text(message!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showConfirmationPopup(String message) {
    message = "Do you perform this action";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: AppColor.white,
            title: const Text('Are you sure?'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildShimmerHeadingContent({
    double width = AppDimen.appShimmerHeadingWidth,
    double height = AppDimen.appShimmerHeadingHeight,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(6))),
        height: height,
        width: width,
      ),
    );
  }

  Widget buildShimmerCircularContent(
      {double radius = AppDimen.appShimmerCircularRadius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColor.primary,
      ),
    );
  }

  Widget buildShimmerRoundRectangleContent(
      {double size = AppDimen.appShimmerHeadingWidth,
      double radius = AppDimen.appShimmerCircularRadius,
      bool isRadius = false}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: isRadius ? radius * 10 : size,
        width: size,
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget buildListShimmer(Widget itemWidget,
      {int itemCount = 10, Axis scrollDirection = Axis.vertical}) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      controller: ScrollController(),
      itemCount: itemCount,
      physics: const ScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
          padding: scrollDirection == Axis.horizontal
              ? const EdgeInsets.only(right: 15.0)
              : const EdgeInsets.only(bottom: 15.0),
          child: itemWidget,
        );
      },
    );
  }

  Widget buildListShimmerWithIndex(Widget Function(int index) itemWidget,
      {int itemCount = 10, Axis scrollDirection = Axis.vertical}) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      controller: ScrollController(),
      itemCount: itemCount,
      physics: const ScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
          padding: scrollDirection == Axis.horizontal
              ? const EdgeInsets.only(right: 15.0)
              : const EdgeInsets.only(bottom: 15.0),
          child: itemWidget(index),
        );
      },
    );
  }

  Widget buildGridShimmer({
    Widget itemWidget = const SizedBox(),
    int itemCount = 10,
    int crossAxisCount = 2,
    double crossAxisSpacing = 10,
    double mainAxisSpacing = 10,
    double mainAxisExtent = 240,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          mainAxisExtent: mainAxisExtent,
          childAspectRatio: 1.2),
      itemBuilder: (_, index) {
        return itemWidget;
      },
    );
  }

  Widget buildShimmerDataContent(
      {double width = AppDimen.appShimmerDataWidth,
      double height = AppDimen.appShimmerDataHeight,
      double radius = 0,
      bool isPadding = true}) {
    return Padding(
      padding: !isPadding ? EdgeInsets.zero : const EdgeInsets.only(top: 8.0),
      child: Shimmer.fromColors(
        // direction: ShimmerDirection.ttb,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          height: height,
          width: width,
        ),
      ),
    );
  }

  Widget vGap({double height = AppDimen.appVerticalSpacing}) => SizedBox(
        height: height,
      );

  Widget hGap({double width = AppDimen.appHorizontalSpacing}) => SizedBox(
        width: width,
      );

  Widget vDivider(
      {double width = 1,
      double height = 50,
      bool isMargin = true,
      Color color = AppColor.greyDark}) {
    return Container(
      width: width,
      height: height,
      color: color, // Outline color
      margin: EdgeInsets.symmetric(vertical: isMargin ? 8.0 : 0),
    );
  }

  Widget hDivider(
      {double width = double.infinity,
      double height = 0.5,
      Color color = AppColor.primary,
      bool isCustomMargin = false,
      EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8.0)}) {
    return Container(
      width: width,
      height: height,
      color: color, // Outline color
      margin:
          isCustomMargin ? margin : const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}
