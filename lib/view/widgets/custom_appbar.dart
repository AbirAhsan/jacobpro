import 'package:flutter/material.dart';
import 'package:service/services/page_navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool hideNotificationIcon;

  const CustomAppBar(
      {Key? key, required this.title, this.hideNotificationIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ""),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}