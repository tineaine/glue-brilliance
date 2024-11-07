import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:window_manager/window_manager.dart';

import 'button/sub_menu_button.dart';

class Titlebar extends StatefulWidget {
  const Titlebar({super.key});

  @override
  State<Titlebar> createState() => _TitlebarState();
}

class _TitlebarState extends State<Titlebar> {
  bool isMaximized = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.black87,
      child: Row(
        children: [
          SubMenuButton(),
          Expanded(child: Container()),
          IconButton(
              onPressed: () => {windowManager.minimize()},
              tooltip: "最小化",
              icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedMinusSign,
                  size: 13,
                  color: Colors.white)),
          IconButton(
              onPressed: () => {
                    if (isMaximized)
                      {
                        windowManager.unmaximize(),
                        isMaximized = false,
                      }
                    else
                      {
                        windowManager.maximize(),
                        isMaximized = true,
                      }
                  },
              tooltip: "窗口化",
              icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedSquare,
                  size: 13,
                  color: Colors.white)),
          IconButton(
              onPressed: () => {
                    // TODO: 检查是否有未保存的数据
                    // 结束进程运行
                    exit(0),
                  },
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
