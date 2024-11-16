import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management_setu/common/base_page.dart';
import 'package:task_management_setu/res/res.dart';
import 'package:task_management_setu/ui/ui.dart';

class ViewToDoListItem extends StatefulWidget {
  final String title;
  final String description;
  final String creationDate;
  final String deadline;
  final bool isCompleted;
  final ValueChanged<bool>? onToggleComplete;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final Function()? onTap;
  final bool isLoading;

  const ViewToDoListItem({
    super.key,
    this.title = "Test",
    this.description = "NA",
    this.creationDate = "",
    this.deadline = "",
    this.isCompleted = false,
    this.onToggleComplete,
    this.onDelete,
    this.onEdit,
    this.onTap,
    this.isLoading = false,
  });

  @override
  State<ViewToDoListItem> createState() => _ViewToDoListItemState();
}

class _ViewToDoListItemState extends State<ViewToDoListItem>
    with BasePageState {
  @override
  Widget build(BuildContext context) {
    // Get theme data
    final theme = Theme.of(context);

    return CommonContainer(
      rippleEffect: true,
      margin: const EdgeInsets.all(8.0),
      onTap: widget.onTap,
      child: Row(
        children: [
          // Status Indicator
          widget.isLoading
              ? const SizedBox.shrink()
              : Container(
                  width: 5.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: widget.isCompleted
                        ? theme.colorScheme.secondary // Success color
                        : theme.colorScheme.error, // Warning color
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(AppDimen.appBorderRadius),
                      bottomRight: Radius.circular(AppDimen.appBorderRadius),
                    ),
                  ),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isLoading
                      ? buildShimmerDataContent(
                          width: AppDimen.appSpace50 * 2,
                          height: AppDimen.appSpace15,
                        )
                      : Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.isCompleted
                                ? theme.textTheme.bodyLarge!
                                    .color // Grey for completed
                                : theme.textTheme.headlineLarge!.color,
                            // Primary color for not completed
                            decoration: widget.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                  vGap(height: AppDimen.appSpace10 - 2),
                  widget.isLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildShimmerDataContent(
                              width:
                                  AppDimen.appSpace50 * 2 + AppDimen.appSpace30,
                              height: AppDimen.appSpace10,
                            ),
                            buildShimmerDataContent(
                              width:
                                  AppDimen.appSpace50 * 2 - AppDimen.appSpace40,
                              height: AppDimen.appSpace10,
                            ),
                          ],
                        )
                      : Text(
                          widget.description,
                          style: TextStyle(
                              fontSize: 14,
                              color: theme.textTheme.bodyMedium!
                                  .color), // Secondary text color
                        ),
                  vGap(height: AppDimen.appSpace5),
                  widget.isLoading
                      ? Row(
                          children: [
                            buildShimmerDataContent(
                              width: AppDimen.appSpace30,
                              height: AppDimen.appSpace10,
                            ),
                            buildShimmerDataContent(
                              width: AppDimen.appSpace50 + AppDimen.appSpace30,
                              height: AppDimen.appSpace10,
                            ),
                          ],
                        )
                      : Text(
                          'Due: ${widget.deadline}',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.error), // Red for due date
                        ),
                ],
              ),
            ),
          ),

          widget.isLoading
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Transform.scale(
                      scale: 0.8, // Adjust scale as per icon size
                      child: Switch(
                        splashRadius: 5,
                        value: widget.isCompleted,
                        onChanged: (value) {
                          if (widget.onToggleComplete != null) {
                            widget.onToggleComplete!(value);
                          } else {
                            print('onToggleComplete is not defined');
                          }
                        },
                        activeColor: theme.colorScheme.secondary,
                        // Active color
                        inactiveThumbColor:
                            theme.colorScheme.error, // Inactive color
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onEdit,
                        child: SvgPicture.asset(
                          height: AppDimen.appIconSize,
                          AppImage.icEdit,
                          colorFilter: ColorFilter.mode(
                            theme.iconTheme.color!, // Icon color from theme
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onDelete,
                        child: SvgPicture.asset(
                          height: AppDimen.appIconSize,
                          AppImage.icDelete,
                          colorFilter: ColorFilter.mode(
                            AppColor.error, // Error color for delete icon
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
