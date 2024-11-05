import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/design/design.dart';
import 'button.dart';

class InfoComp extends StatefulWidget {
  const InfoComp({super.key});

  @override
  State<InfoComp> createState() => _InfoCompState();
}

class _InfoCompState extends State<InfoComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Image(image: AssetImage('assets/images/app_icon_256.png')),
        const Text(
          "Glue Brilliance",
          style: TextStyle(
            fontSize: 35,
            fontFamily: "dingtalk",
            color: Color.fromARGB(255, 25, 82, 148),
          ),
        ),
        const Text(
          'Glue Open Platform Business Design Toolkit',
          style: TextStyle(
            fontSize: 15,
            fontFamily: "dingtalk",
            color: Color.fromARGB(255, 150, 150, 150),
          ),
        ),
        const SizedBox(height: 15),
        QButton(
          text: 'Create',
          size: const Size(400, 60),
          color: const Color.fromARGB(255, 0, 58, 129),
          onPressed: () => {
            // 导航到工作空间创建页面
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DesignPage()),
            )
          },
        ),
        const SizedBox(height: 15),
        const Text(
          '已有工作空间？点击此处打开',
          style: TextStyle(
            fontSize: 15,
            fontFamily: "dingtalk",
            color: Color.fromARGB(255, 89, 89, 89),
          ),
        ),
      ],
    ),);
  }
}
