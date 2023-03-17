import 'package:flutter/material.dart';

import '../variables/text_style.dart';

class CustomCollapsibleWidget extends StatefulWidget {
  final Widget child;
  final bool initiallyCollapsed;

  const CustomCollapsibleWidget(
      {super.key, required this.child, required this.initiallyCollapsed});

  @override
  State<CustomCollapsibleWidget> createState() =>
      _CustomCollapsibleWidgetState();
}

class _CustomCollapsibleWidgetState extends State<CustomCollapsibleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  bool _isCollapsed = true;

  @override
  void initState() {
    super.initState();
    _isCollapsed = widget.initiallyCollapsed;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
      if (_isCollapsed) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: _toggleCollapse,
          child: Container(
            padding: const EdgeInsets.all(
              15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Driving License".toUpperCase(),
                  style: CustomTextStyle.mediumBoldStyleDarkGrey,
                ),
                Icon(
                    _isCollapsed ? Icons.arrow_drop_down : Icons.arrow_drop_up),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            height: _isCollapsed ? 0 : null,
            margin: EdgeInsets.only(top: _isCollapsed ? 0 : 8),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
