import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../variables/colors_variable.dart';

class CustomShimmerEffect extends StatelessWidget {
  final Widget child;
  const CustomShimmerEffect({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColors.grey,
      highlightColor: CustomColors.lightgrey,
      enabled: true,
      child: child,
    );
  }
}
