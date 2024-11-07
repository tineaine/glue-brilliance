import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsolePanel extends StatefulWidget {
  const ConsolePanel({super.key});

  @override
  State<ConsolePanel> createState() => _ConsolePanelState();
}

class _ConsolePanelState extends State<ConsolePanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
