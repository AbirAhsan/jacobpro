import 'package:flutter/material.dart';
import 'package:service/view/widgets/custom_appbar.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Job List",
      ),
    );
  }
}
