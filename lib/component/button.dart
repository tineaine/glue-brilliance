import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QButton extends StatefulWidget {
  final String text;
  final Size size;
  final Color color;
  final VoidCallback? onPressed; // 使用 VoidCallback 类型，并允许为 null

  const QButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.size,
      required this.color}); // 添加 onPressed 参数

  @override
  State<QButton> createState() => _QButtonState();
}

class _QButtonState extends State<QButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(widget.color),
        minimumSize: WidgetStateProperty.all(widget.size),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 25,
          fontFamily: "dingtalk",
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
