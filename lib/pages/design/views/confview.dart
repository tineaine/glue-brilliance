import 'package:flutter/cupertino.dart';

import '../../../event/design.dart';
import '../../../event/event.dart';

class Confview extends StatefulWidget {
  const Confview({super.key});

  @override
  State<Confview> createState() => ConfviewState();
}

class ConfviewState extends State<Confview> {
  Future<void> save() async {}

  @override
  void initState() {
    super.initState();
    // 订阅存储方法触发事件
    eventBus.on<SaveEvent>().listen((event) {
      if (event.types == 'confview') {
        save();
      }
    });
    eventBus.on<RedoEvent>().listen((event) {
      if (event.types == 'confview') {
        redo();
      }
    });
    eventBus.on<UndoEvent>().listen((event) {
      if (event.types == 'confview') {
        undo();
      }
    });
    eventBus.on<RefreshEvent>().listen((event) {
      if (event.types == 'confview') {
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
