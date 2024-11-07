import 'package:flutter/cupertino.dart';

import '../../../common/panel.dart';

class CompPanel extends StatefulWidget {
  const CompPanel({super.key});

  @override
  State<CompPanel> createState() => _CompPanelState();
}

class _CompPanelState extends State<CompPanel> {
  @override
  Widget build(BuildContext context) {
    return CommonPanel(name: "组件",border: "right",);

  }
}
