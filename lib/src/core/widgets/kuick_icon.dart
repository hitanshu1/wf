import 'package:flutter/material.dart';

class KuickIcon extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? size;
  const KuickIcon(this.icon,{super.key, this.color, this.size,});

  @override
  Widget build(BuildContext context) {
    return Icon(icon,color: color,size: size,);
  }
}
