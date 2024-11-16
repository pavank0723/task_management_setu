import 'package:flutter/material.dart';
import 'package:task_management_setu/res/res.dart';

class ViewSectionContainer extends StatelessWidget {
  final Widget child;
  final bool isPadding;

  const ViewSectionContainer({
    super.key,
    required this.child,
    this.isPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: isPadding
          ? const EdgeInsets.symmetric(
              vertical: AppDimen.appSpace10,
            )
          : EdgeInsets.zero,
      child: child,
    );
  }
}
