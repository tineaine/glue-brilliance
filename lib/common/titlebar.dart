import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Titlebar extends StatefulWidget {
  const Titlebar({super.key});

  @override
  State<Titlebar> createState() => _TitlebarState();
}

class _TitlebarState extends State<Titlebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.black87,
      child: Row(
        children: [
          TextButton(
              onPressed: () => {},
              child: Text("Glue Brilliance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: "dingtalk",
                    color: Color.fromARGB(255, 255, 255, 255),
                    decoration: TextDecoration.none,
                  ))),
          Expanded(child: Container()),
          IconButton(
              onPressed: () => {},
              tooltip: "退出蓝图编辑器",
              icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedCancel01,
                  size: 13,
                  color: Colors.white))
        ],
      ),
    );
  }
}
