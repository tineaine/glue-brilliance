import 'package:flutter/cupertino.dart';

import '../../../common/panel.dart';

class AttrPanel extends StatefulWidget {
  const AttrPanel({super.key});

  @override
  State<AttrPanel> createState() => _AttrPanelState();
}

class _AttrPanelState extends State<AttrPanel> {
  @override
  Widget build(BuildContext context) {
    return CommonPanel(name: "属性",);

  }
}
