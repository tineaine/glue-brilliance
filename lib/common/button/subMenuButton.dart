import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SubMenuButton extends StatefulWidget {
  const SubMenuButton({super.key});



  @override
  _SubMenuButtonState createState() => _SubMenuButtonState();
}

class _SubMenuButtonState extends State<SubMenuButton> {
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;



  void _showMenu(BuildContext context, Offset buttonPosition) {
    if (_isMenuOpen) {
      _hideMenu();
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: buttonPosition.dy + 30, // 调整菜单的位置
        left: buttonPosition.dx,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: makeListTile(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
    _isMenuOpen = true;
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _isMenuOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final RenderBox buttonBox = context.findRenderObject() as RenderBox;
        final Offset buttonPosition = buttonBox.localToGlobal(Offset.zero);
        _showMenu(context, buttonPosition);
      },
      child: Text("Glue Brilliance",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            fontFamily: "dingtalk",
            color: Color.fromARGB(255, 255, 255, 255),
            decoration: TextDecoration.none,
          )),
    );
  }

  List<Widget> makeListTile() {
    List<String> menuItems = ['文件', '编辑', '视图', "视图", "部署", "工具", "关于"];

    List<Widget> menuItemWidgets = [];

    for (String item in menuItems) {
      menuItemWidgets.add(ListTile(
        leading: HugeIcon(
            icon: HugeIcons.strokeRoundedMenu02,
            size: 13,
            color: Colors.black54),
        title:
            Text(item, style: TextStyle(fontSize: 13,fontFamily: "dingtalk", color: Colors.black54)),
        onTap: () {
          _hideMenu();
          // 处理选项的点击事件
        },
      ));
    }

    return menuItemWidgets;
  }
}
