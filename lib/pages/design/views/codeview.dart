import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:highlight/languages/json.dart';

import '../../../event/design.dart';
import '../../../event/event.dart';

class Codeview extends StatefulWidget {
  final String filePath;

  const Codeview({super.key, required this.filePath});

  @override
  State<Codeview> createState() => CodeviewState();
}

class CodeviewState extends State<Codeview> {
  late CodeController _codeController;

  void asave() {
    print('Child method called');
  }

  @override
  void initState() {
    super.initState();
    // 订阅存储方法触发事件
    eventBus.on<SaveEvent>().listen((event) {
      if (event.types == 'codeview') {
        save();
      }
    });
    eventBus.on<RedoEvent>().listen((event) {
      if (event.types == 'codeview') {
        redo();
      }
    });
    eventBus.on<UndoEvent>().listen((event) {
      if (event.types == 'codeview') {
        undo();
      }
    });
    eventBus.on<RefreshEvent>().listen((event) {
      if (event.types == 'codeview') {
        refresh();
      }
    });

    _codeController = CodeController(
        text: '',
        language: json,
    );
    _readFile();
  }

  refresh() {}

  undo() {}

  redo() {}


  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _readFile() async {
    try {
      final file = File(widget.filePath);
      final content = await file.readAsString();
      setState(() {
        _codeController.text = content;
      });
    } catch (e) {
      setState(() {
      });
    }
  }

  Future<void> save() async {
    try {
      final file = File(widget.filePath);
      await file.writeAsString(_codeController.text);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('文件已保存')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存失败: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: CodeTheme(
                  data: CodeThemeData(styles: xcodeTheme),
                  child: SingleChildScrollView(
                    child: CodeField(
                      controller: _codeController,
                    ),
                  ),
                ),
                // child: CodeField(
                //   controller: _codeController,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
