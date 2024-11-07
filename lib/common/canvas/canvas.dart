import 'package:flutter/material.dart';

class MainCanvas extends StatefulWidget {
  const MainCanvas({super.key});

  @override
  State<MainCanvas> createState() => _MainCanvasState();
}

class _MainCanvasState extends State<MainCanvas> {
  final List<Map<String, dynamic>> _stackChildren = [];

  void _addNewElement() {
    setState(() {
      _stackChildren.add({
        'offset': const Offset(0.0, 0.0),
        'widget': Draggable(
          data: 'Draggable Data',
          feedback: Material(
            child: Container(
              width: 85.0,
              height: 45.0,
              decoration: const BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: const Center(
                child: Text(
                  '开始节点',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      decoration: null),
                ),
              ),
            ),
          ),
          childWhenDragging: Container(),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              final index = _stackChildren.length - 1;
              _stackChildren[index]['offset'] =
                  Offset(offset.dx - 45.0, offset.dy - 30.0);
            });
          },
          child: Container(
            width: 80.0,
            height: 40.0,
            decoration: const BoxDecoration(
              color: Color.fromARGB(200, 100, 100, 100),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: const Center(
              child: Text(
                '开始节点',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    decoration: null),
              ),
            ),
          ),
        ),
      });
    });
  }

  void _showContextMenu(BuildContext context, Offset position) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            position.dx, position.dy, position.dx, position.dy),
        items: [
          PopupMenuItem(
              child: const Text('添加'),
              onTap: () {
                _addNewElement();
              })
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          // print("-");
        },
        onSecondaryTapDown: (details)
    {
      // print("object");
      _showContextMenu(context, details.globalPosition);
    },
    child: Stack(
    children: _stackChildren.map((item) {
    return Positioned(
    left: item['offset'].dx,
    top: item['offset'].dy,
    child: item['widget'],
    );
    }).toList(),
    ),
    );
  }
}
