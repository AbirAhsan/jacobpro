import 'package:flutter/material.dart';
import 'package:service/services/page_navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool hideNotificationIcon;
  final PreferredSizeWidget? bottom;
  final double? elevation;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.hideNotificationIcon = false,
    this.bottom,
    this.elevation = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ""),
      elevation: elevation,
      actions: [
        hideNotificationIcon
            ? Container()
            : IconButton(
                onPressed: () {
                  PageNavigationService.generalNavigation(
                      "/NotificationScreen");
                },
                icon: const Icon(Icons.notifications_active_outlined))
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
