
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class QMenuButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color color;
  final bool disabled;
  final bool isSelected;

  const QMenuButton(
      {super.key,
      required this.iconData,
      this.onPressed,
      this.tooltip,
      this.color = Colors.black54,
      this.disabled = false,
      this.isSelected = false});

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
        disabledColor: Colors.black26,
        isSelected: widget.isSelected,
        splashRadius: 20,
        onPressed: widget.disabled ? null : widget.onPressed,
        tooltip: widget.tooltip,
        color: widget.isSelected ? Colors.blue : Colors.black54,
        hoverColor: Colors.black12,
        focusColor: Colors.black26,

        icon: HugeIcon(icon: widget.iconData, size: 15, color: widget.color),
        style: ButtonStyle(
          shadowColor: WidgetStateProperty.all(Colors.black26),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
