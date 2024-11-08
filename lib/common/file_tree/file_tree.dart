import 'package:brilliance/event/design.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:hugeicons/hugeicons.dart';

import '../../event/event.dart';

class ProjectTree extends StatefulWidget {
  final String directoryPath;

  const ProjectTree({required this.directoryPath, super.key});

  @override
  State<ProjectTree> createState() => _ProjectTreeState();
}

class _ProjectTreeState extends State<ProjectTree> {
  late Directory _directory;
  List<FileSystemEntity> _fileSystemEntities = [];

  // 蓝图（业务处理）

  // 触发（事件、时间触发执行）

  // API（外部通信）

  // 引用（Simx 扩展）

  // 代理（Simx 代理）

  // 蓝图数据
  List<CustomNode> apiNode = [
    CustomNode(name: '用户API', type: 'api', path: "/Users/eyresimpson/Downloads/aaa.json"),
    CustomNode(name: '目录API', type: 'api', path: "/Users/eyresimpson/Downloads/aaa.json"),
    CustomNode(name: '测试API', type: 'api', path: "/Users/eyresimpson/Downloads/aaa.json"),
    CustomNode(name: '管理台API', type: 'api', path: "/Users/eyresimpson/Downloads/aaa.json"),
    CustomNode(name: '物流API', type: 'api', path: "/Users/eyresimpson/Downloads/aaa.json"),
    CustomNode(name: '其他API', type: 'api', path: "/Users/eyresimpson/Downloads/aaa.json"),
  ];
  List<CustomNode> bpNode = [
    CustomNode(name: '测试蓝图1', type: 'blueprint', path: "/Users/eyresimpson/Downloads/qqq.json"),
    CustomNode(name: '测试蓝图2', type: 'blueprint', path: "/Users/eyresimpson/Downloads/qqq.json"),
    CustomNode(name: '测试蓝图3', type: 'blueprint', path: "/Users/eyresimpson/Downloads/qqq.json"),
    CustomNode(name: '测试蓝图4', type: 'blueprint', path: "/Users/eyresimpson/Downloads/qqq.json"),
    CustomNode(name: '测试蓝图5', type: 'blueprint', path: "/Users/eyresimpson/Downloads/qqq.json"),
    CustomNode(name: '测试蓝图6', type: 'blueprint', path: "/Users/eyresimpson/Downloads/qqq.json"),
  ];
  List<CustomNode> triggerNode = [
    CustomNode(name: '定时触发', type: 'trigger', path: "/Users/eyresimpson/Downloads/ccc.json"),
    CustomNode(name: '事件触发', type: 'trigger', path: "/Users/eyresimpson/Downloads/ccc.json"),
  ];
  List<CustomNode> refNode = [
    CustomNode(name: 'Simx Http', type: 'ref', path: "/Users/eyresimpson/Downloads/bbb.json"),
    CustomNode(name: 'Simx RPA', type: 'ref', path: "/Users/eyresimpson/Downloads/bbb.json"),
    CustomNode(name: 'Simx OPS', type: 'ref', path: "/Users/eyresimpson/Downloads/bbb.json"),
    CustomNode(name: 'Simx Nacos', type: 'ref', path: "/Users/eyresimpson/Downloads/bbb.json"),
    CustomNode(name: 'Simx MySQL', type: 'ref', path: "/Users/eyresimpson/Downloads/bbb.json"),
    CustomNode(name: 'Simx Redis', type: 'ref', path: "/Users/eyresimpson/Downloads/bbb.json"),
  ];
  List<CustomNode> confNode = [
    CustomNode(name: '项目配置', type: 'conf', path: "/Users/eyresimpson/Downloads/bbb.json"),
    CustomNode(name: 'Http配置', type: 'conf', path: "/Users/eyresimpson/Downloads/bbb.json"),
  ];

  @override
  void initState() {
    super.initState();
    _directory = Directory(widget.directoryPath);
    _loadDirectoryContents();
  }

  // 刷新数据结构
  void refresh() {
    // _loadDirectoryContents();
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

  List<FileSystemEntity> _getDirectoryContents(Directory directory) {
    try {
      return directory.listSync();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildTopLevelTile('蓝图', 'blueprint'),
        _buildTopLevelTile('接口', 'api'),
        _buildTopLevelTile('触发', 'trigger'),
        _buildTopLevelTile('资源', 'trigger'),
        _buildTopLevelTile('配置', 'api'),
        _buildTopLevelTile('引用', 'ref'),
      ],
    );
  }

  Widget _buildTopLevelTile(String title, String subdirectoryName) {
    return ExpansionTile(
      // 子内容间距
      childrenPadding: const EdgeInsets.only(left: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      leading: HugeIcon(
        icon: HugeIcons.strokeRoundedFolder02,
        color: Colors.black54,
        size: 14,
      ),
      trailing: HugeIcon(
        icon: HugeIcons.strokeRoundedArrowDown01,
        color: Colors.black54,
        size: 14,
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.black54, fontSize: 14, fontFamily: 'dingtalk')),
      children: subdirectoryName == 'api'
          ? buildSubNode(apiNode)
          : subdirectoryName == 'blueprint'
              ? buildSubNode(bpNode)
              : subdirectoryName == 'trigger'
                  ? buildSubNode(triggerNode)
                  : buildSubNode(refNode),
    );
  }

  List<Widget> buildSubNode(List<CustomNode> nodes) {
    List<Widget> widgets = [];
    for (CustomNode node in nodes) {
      widgets.add(ListTile(
          onTap: () {
            eventBus.fire(OpenEvent(node.type, node.path));
          },
          leading: HugeIcon(
            icon: node.type == "blueprint"
                ? HugeIcons.strokeRoundedCompass01
                : node.type == "api"
                    ? HugeIcons.strokeRoundedApi
                    : node.type == "trigger"
                        ? HugeIcons.strokeRoundedFileScript
                        : HugeIcons.strokeRoundedPlug01,
            color: Colors.black54,
            size: 13,
          ),
          title: Text(node.name,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontFamily: 'dingtalk'))));
    }
    return widgets;
  }
}

class CustomDirNode {
  String name;
  List<CustomNode> children;

  CustomDirNode({required this.name, required this.children});
}

class CustomNode {
  String name;
  String type;
  String path;

  CustomNode({required this.name, required this.type, required this.path});
}
