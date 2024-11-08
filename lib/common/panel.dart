import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'button/menu_button.dart';

class CommonPanel extends StatefulWidget {
  final String name;

  final String border;

  final Widget content;

  const CommonPanel(
      {super.key,
      required this.name,
      this.content = const Text(""),
      this.border = "left"});

  @override
  State<CommonPanel> createState() => _CommonPanelState();
}

class _CommonPanelState extends State<CommonPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: widget.border == "right"
                ? BorderSide(
                    color: Color.fromARGB(255, 239, 239, 239),
                    width: 1.0,
                  )
                : BorderSide.none,
            left: widget.border == "left"
                ? BorderSide(
                    color: Color.fromARGB(255, 239, 239, 239),
                    width: 1.0,
                  )
                : BorderSide.none,
            top: widget.border == "top"
                ? BorderSide(
              color: Color.fromARGB(255, 239, 239, 239),
              width: 1.0,
            )
                : BorderSide.none,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "dingtalk",
                        color: Colors.black87,
                        decoration: TextDecoration.none),
                  ),
                  Spacer(),
                  QMenuButton(
                      iconData: HugeIcons.strokeRoundedAddCircle,
                      tooltip: "添加",
                      onPressed: () => {}),
                  QMenuButton(
                      iconData: HugeIcons.strokeRoundedRefresh,
                      tooltip: "刷新",
                      onPressed: () => {}),
                  QMenuButton(
                      iconData: HugeIcons.strokeRoundedMoreVertical,
                      tooltip: "更多",
                      onPressed: () => {})
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
              // 主要内容
              widget.content
            ]));
  }
}
