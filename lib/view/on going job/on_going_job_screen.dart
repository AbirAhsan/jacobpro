import 'package:flutter/material.dart';
import 'package:service/view/widgets/custom_appbar.dart';

class OnGoingJobScreen extends StatelessWidget {
  const OnGoingJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "On Going Job",
        hideNotificationIcon: true,
      ),
    );
  }
}
