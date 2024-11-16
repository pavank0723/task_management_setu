import 'package:flutter/material.dart';
import 'package:task_management_setu/res/res.dart';

class CommonContainer extends StatefulWidget {
  final Widget child;
  final Function()? onTap;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final BoxDecoration? decoration;

  final bool rippleEffect;

  const CommonContainer({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.boxShadow,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.rippleEffect = true,
    this.height,
    this.width,
    this.backgroundColor,
    this.decoration,
  });

  @override
  State<CommonContainer> createState() => _CommonContainerState();
}

class _CommonContainerState extends State<CommonContainer> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        if (widget.rippleEffect) {
          setState(() {
            isTapped = true;
          });
        }
      },
      onTapCancel: () {
        if (widget.rippleEffect) {
          setState(() {
            isTapped = false;
          });
        }
      },
      onTap: () {
        if (widget.onTap != null && widget.rippleEffect) {
          widget.onTap!();
        }
        setState(() {
          isTapped = false;
        });
      },
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        height: widget.height,
        width: widget.width,
        decoration: widget.decoration ??
            BoxDecoration(
              color: widget.backgroundColor ?? theme.cardColor, // Use theme background color
              borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(AppDimen.appWidgetRadius)),
              boxShadow: isTapped && widget.rippleEffect
                  ? []
                  : (widget.boxShadow ?? [
                BoxShadow(
                  color: theme.shadowColor, // Use theme shadow color
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                ),
              ]),
            ),
        child: widget.child,
      ),
    );
  }
}
