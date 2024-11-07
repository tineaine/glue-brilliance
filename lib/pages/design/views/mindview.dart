import 'package:flutter/cupertino.dart';

import '../../../event/design.dart';
import '../../../event/event.dart';

class Mindview extends StatefulWidget {
  const Mindview({super.key});

  @override
  State<Mindview> createState() => MindviewState();
}

class MindviewState extends State<Mindview> {
  Future<void> save() async {}

  @override
  void initState() {
    super.initState();
    // 订阅存储方法触发事件
    eventBus.on<SaveEvent>().listen((event) {
      if (event.types == 'blueprint') {
        save();
      }
    });
    eventBus.on<RedoEvent>().listen((event) {
      if (event.types == 'blueprint') {
        redo();
      }
    });
    eventBus.on<UndoEvent>().listen((event) {
      if (event.types == 'blueprint') {
        undo();
      }
    });
    eventBus.on<RefreshEvent>().listen((event) {
      if (event.types == 'blueprint') {
        refresh();
      }
    });
  }

  refresh() {}

  undo() {}

  redo() {}


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
