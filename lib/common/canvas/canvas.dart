import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';

class MainCanvas extends StatefulWidget {
  const MainCanvas({super.key});

  @override
  State<MainCanvas> createState() => _MainCanvasState();
}

class _MainCanvasState extends State<MainCanvas> {
  final GlobalKey _canvasKey = GlobalKey();
  List<Map<String, dynamic>> elements = [];
  Offset _offset = Offset.zero;
  bool _isDragging = false;
  bool _isSpacePressed = false;

  void _showContextMenu(BuildContext context, Offset position) {
    showMenu(
        context: context,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        position: RelativeRect.fromLTRB(
            position.dx, position.dy, position.dx, position.dy),
        items: makeListTile());
  }

  List<PopupMenuItem> makeListTile() {
    List<String> menuItems = ['查看属性', '刷新画布', '刷新缓存', '单点运行'];

    List<PopupMenuItem> menuItemWidgets = [];

    for (String item in menuItems) {
      menuItemWidgets.add(PopupMenuItem(
        onTap: () {},
        child: Row(
          children: [
            HugeIcon(icon: HugeIcons.strokeRoundedMenu03, size: 13, color: Colors.black54),
            // SizedBox.square(),
            SizedBox(width: 10,),
            Text(item,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "dingtalk",
                    color: Colors.black54))
          ],
        ),
      ));
    }

    return menuItemWidgets;
  }

  void _addNewElement(Offset globalOffset) {
    RenderBox renderBox =
        _canvasKey.currentContext!.findRenderObject() as RenderBox;
    Offset localOffset = renderBox.globalToLocal(globalOffset);

    setState(() {
      elements.add({
        'position': localOffset,
        'content': '双击位置',
      });
    });
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.space) {
      setState(() {
        _isSpacePressed = true;
      });
    } else if (event is RawKeyUpEvent &&
        event.logicalKey == LogicalKeyboardKey.space) {
      setState(() {
        _isSpacePressed = false;
        _isDragging = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: _handleKeyEvent,
      child: MouseRegion(
        cursor: _isSpacePressed
            ? SystemMouseCursors.grab
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onDoubleTapDown: (TapDownDetails details) {
            // 获取鼠标点击的全局位置
            Offset globalPosition = details.globalPosition;
            _addNewElement(globalPosition);
          },
          // 右键点击
          onSecondaryTapDown: (TapDownDetails details) {
            _showContextMenu(context, details.globalPosition);
          },
          onPanStart: (DragStartDetails details) {
            if (_isSpacePressed) {
              _isDragging = true;
            }
          },
          onPanUpdate: (DragUpdateDetails details) {
            if (_isDragging) {
              setState(() {
                _offset += details.delta;
              });
            }
          },
          onPanEnd: (DragEndDetails details) {
            if (_isDragging) {
              _isDragging = false;
            }
          },
          child: Transform.translate(
            offset: _offset,
            child: CustomPaint(
              key: _canvasKey,
              size: Size.infinite,
              painter: MyPainter(elements: elements),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Map<String, dynamic>> elements;

  MyPainter({required this.elements});

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制背景
    Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // 绘制元素
    for (var element in elements) {
      Offset position = element['position'];
      String content = element['content'];

      // 计算矩形的位置和大小
      double rectWidth = 300;
      double rectHeight = 80;
      Rect rect =
          Rect.fromLTWH(position.dx, position.dy, rectWidth, rectHeight);

      // 绘制灰色边框的矩形
      Paint rectPaint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawRect(rect, rectPaint);

      // 绘制文字
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: content,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16.0,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // 计算文字的位置
      double textX = position.dx + 10; // 留出一些边距
      double textY = position.dy + rectHeight / 2 - textPainter.height / 2;

      textPainter.paint(canvas, Offset(textX, textY));

      // 绘制图标
      final icon = Icons.info; // 使用一个示例图标
      final iconSize = 24.0;
      final iconPaint = Paint()..color = Colors.blue;

      // 计算图标的中心位置
      double iconX = position.dx + rectWidth - iconSize - 10; // 靠右留出一些边距
      double iconY = position.dy + rectHeight / 2;

      // 绘制图标
      canvas.drawCircle(Offset(iconX, iconY), iconSize / 2, iconPaint);
      // canvas.draw
      // canvas.drawImage(icon.image, Offset(iconX - iconSize / 2, iconY - iconSize / 2), Paint());
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
