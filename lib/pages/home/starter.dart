import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../design/design.dart';
import '../../common/button/button.dart';

class InfoComp extends StatefulWidget {
  const InfoComp({super.key});

  @override
  State<InfoComp> createState() => _InfoCompState();
}

class _InfoCompState extends State<InfoComp> {
  @override
  void initState() {
    windowManager.setMinimumSize(Size(800, 500));
    windowManager.setSize(Size(800, 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Logo 图片
          // const Image(image: AssetImage('assets/images/app_icon_256.png'), width: 150, height: 150,),
          const SizedBox(height: 30),
          const Text(
            "Glue Brilliance IDE",
            style: TextStyle(
              fontSize: 30,
              fontFamily: "dingtalk",
              color: Color.fromARGB(255, 0, 0, 0),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Glue Open Platform Business Develop And Design IDE',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "dingtalk",
              color: Color.fromARGB(100, 100, 100, 100),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 30),
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
          TextButton(
            onPressed: () => {
              // 导航到工作空间创建页面
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DesignPage()),
              )
            },
            child: Text(
              '已有工作空间？点击此处打开',
              style: TextStyle(
                fontSize: 15,
                fontFamily: "dingtalk",
                color: Color.fromARGB(255, 89, 89, 89),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
