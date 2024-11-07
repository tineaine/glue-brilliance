import 'package:flutter/material.dart';
import 'dart:io';

import 'package:hugeicons/hugeicons.dart';

class FileTree extends StatefulWidget {
  final String directoryPath;

  const FileTree({required this.directoryPath, super.key});

  @override
  State<FileTree> createState() => _FileTreeState();
}

class _FileTreeState extends State<FileTree> {
  late Directory _directory;
  List<FileSystemEntity> _fileSystemEntities = [];

  @override
  void initState() {
    super.initState();
    _directory = Directory(widget.directoryPath);
    _loadDirectoryContents();
  }

  Future<void> _loadDirectoryContents() async {
    try {
      _fileSystemEntities = await _directory.list().toList();
      setState(() {});
    } catch (e) {
      // 处理错误
      print('Error loading directory contents: $e');
    }
  }

  Widget _buildFileTree(List<FileSystemEntity> entities) {
    return ListView.builder(
      itemCount: entities.length,
      itemBuilder: (context, index) {
        FileSystemEntity entity = entities[index];
        if (entity is Directory) {
          return ExpansionTile(
            // 圆角
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            leading: HugeIcon(
              icon: HugeIcons.strokeRoundedFolder02,
              color: Colors.black87,
              size: 16,
            ),
            // 前置图标
            trailing: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowDown01,
              color: Colors.black87,
              size: 16,
            ),
            title: Text(entity.path.split('/').last,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'dingtalk')),
            children: [_buildFileTree(_getDirectoryContents(entity))],
          );
        } else if (entity is File) {
          return ListTile(
              leading: HugeIcon(
                icon: HugeIcons.strokeRoundedFile02,
                color: Colors.black87,
                size: 18,
              ),
              title: Text(entity.path.split('/').last,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontFamily: 'dingtalk')));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  List<FileSystemEntity> _getDirectoryContents(Directory directory) {
    try {
      return directory.listSync();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _fileSystemEntities.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _buildFileTree(_fileSystemEntities),
    );
  }
}
