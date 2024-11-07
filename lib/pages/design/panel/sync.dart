import 'package:flutter/cupertino.dart';

import '../../../common/panel.dart';

class SyncPanel extends StatefulWidget {
  const SyncPanel({super.key});

  @override
  State<SyncPanel> createState() => _SyncPanelState();
}

class _SyncPanelState extends State<SyncPanel> {
  @override
  Widget build(BuildContext context) {
    return CommonPanel(name: "版本",border: "right",);

  }
}
