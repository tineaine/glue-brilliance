import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:highlight/languages/json.dart';

class Codeview extends StatefulWidget {
  final String filePath;

  const Codeview({super.key, required this.filePath});

  @override
  State<Codeview> createState() => _CodeviewState();
}

class _CodeviewState extends State<Codeview> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
        text: '',
        language: json,
    );
    _readFile();
  }

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

  Future<void> _saveFile() async {
    try {
      final file = File(widget.filePath);
      await file.writeAsString(_codeController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('文件已保存')),
      );
    } catch (e) {
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
