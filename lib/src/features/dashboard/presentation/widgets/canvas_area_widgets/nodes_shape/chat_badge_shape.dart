import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;

  const ChatBubble({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: AppColor.color5(context),
          border: Border.all(color: color),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(500),
            bottomLeft: Radius.circular(500),
            topLeft: Radius.circular(500),
          )
      ),
      child: child,
    );
  }
}
