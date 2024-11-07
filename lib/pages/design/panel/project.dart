import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:brilliance/common/panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/file_tree/file_tree.dart';
import '../../../common/file_tree/tree.dart';

class ProjectPanel extends StatefulWidget {
  const ProjectPanel({super.key});

  @override
  State<ProjectPanel> createState() => _ProjectPanelState();
}

class _ProjectPanelState extends State<ProjectPanel> {
  @override
  Widget build(BuildContext context) {
    return CommonPanel(
        name: "项目",
        border: "right",
        content: Expanded(
            //     child: FileTree(
            //   directoryPath: './',
            // )
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: TreeView.simple(
                    tree: TreeNode.root(),
                    builder: (context, node) {
                      // build your node item here
                      // return any widget that you need
                      return ListTile(
                        title: Text("Item ${node.level}-${node.key}"),
                        subtitle: Text('Level ${node.level}'),
                      );
                    }))));
  }
}
