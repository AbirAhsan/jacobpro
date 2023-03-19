import 'package:flutter/material.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/widgets/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Notifications",
        hideNotificationIcon: true,
      ),
      body: ListView.builder(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(15.0),
          itemCount: 15,
          itemBuilder: (buildContext, index) {
            return Card(
              child: ListTile(
                leading: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: CustomColors.primary),
                    child: const Icon(
                      Icons.notification_important_outlined,
                      color: CustomColors.white,
                    )),
                title: const Text(
                    "Another exception was thrown: Invalid argument(s): No host specified in URI"),
                subtitle: const Text("10:30 PM"),
                onTap: () {},
              ),
            );
          }),
    );
  }
}
