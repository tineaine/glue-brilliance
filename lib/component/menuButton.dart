import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class QMenuButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final String? tooltip;
  // final
  const QMenuButton({super.key, required this.iconData, this.onPressed, this.tooltip});
  @override
  State<QMenuButton> createState() => _QMenuButtonState();
}

class _QMenuButtonState extends State<QMenuButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        onPressed: widget.onPressed,
        tooltip: widget.tooltip,
        icon: HugeIcon(
            icon: widget.iconData,
            size: 15,
            color: Colors.black54),
        style: ButtonStyle(
          shape:
          WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
