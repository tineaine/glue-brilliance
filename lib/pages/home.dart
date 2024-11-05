import 'package:flutter/material.dart';

import '../component/info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
      // 如果没有读取到工作空间，就显示信息（创建），如果读取到了，就显示项目列表
      child: InfoComp(),
    ),);
  }
}
