import 'package:flutter/cupertino.dart';

import '../../../common/panel.dart';

class StructPanel extends StatefulWidget {
  const StructPanel({super.key});

  @override
  State<StructPanel> createState() => _StructPanelState();
}

class _StructPanelState extends State<StructPanel> {
  @override
  Widget build(BuildContext context) {
    return CommonPanel(name: "结构",border: "right",);

  }
}
