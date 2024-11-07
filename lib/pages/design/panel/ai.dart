import 'package:flutter/cupertino.dart';

import '../../../common/panel.dart';

class AiPanel extends StatefulWidget {
  const AiPanel({super.key});

  @override
  State<AiPanel> createState() => _ProjectPanelState();
}

class _ProjectPanelState extends State<AiPanel> {
  @override
  Widget build(BuildContext context) {
    return CommonPanel(name: "智能",);

  }
}
