import 'package:brilliance/component/canvas.dart';
import 'package:brilliance/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../component/menuButton.dart';
import 'CodeView.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  @override
  void initState() {
    windowManager.maximize();
    windowManager.setMinimumSize(const Size(1000, 600));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isCodeview = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Container(
            height: 30,
            color: Colors.black87,
            child: const Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                Text("Glue Brilliance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: "dingtalk",
                      color: Color.fromARGB(255, 255, 255, 255),
                      decoration: TextDecoration.none,
                    ))
              ],
            ),
          ),
          // 设计区域
          Expanded(
              child: Container(
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 左侧边栏
                Container(
                  // color: Colors.white,
                  width: 45,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      border: Border(
                          right: BorderSide(
                              color: Color.fromARGB(255, 239, 239, 239)))),
                  child: Column(
                    children: [
                      // 工作空间
                      QMenuButton(
                        tooltip: "工作空间",
                        onPressed: () => {},
                        iconData: HugeIcons.strokeRoundedFolder01,
                      ),
                      const SizedBox(height: 10),
                      // 项目
                      QMenuButton(
                        tooltip: "项目文件",
                        onPressed: () => {},
                        iconData: HugeIcons.strokeRoundedFile02,
                      ),
                      const SizedBox(height: 10),
                      // 监视器
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedEye,
                        tooltip: "蓝图监视",
                        onPressed: () => {},
                      ),
                      // 中间空间扩展
                      Expanded(child: Container()),
                      // 控制台
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedConsole,
                        tooltip: "当前问题",
                        onPressed: () => {},
                      ),
                      const SizedBox(height: 10),
                      // 管理台
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedManager,
                        tooltip: "管理中心",
                        onPressed: () => {},
                      ),
                      const SizedBox(height: 10),
                      // 组件库
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedGlobe,
                        tooltip: "组件仓库",
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ),
                // 画布
                Expanded(
                    child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: !isCodeview ? MainCanvas() : const Codeview(filePath: "./test.json"),
                )),
                // 右侧边栏
                Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border(
                            left: BorderSide(
                                color: Color.fromARGB(255, 239, 239, 239)))),
                    width: 45,
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedShopSign,
                          tooltip: "扩展超市",
                          onPressed: () async {
                            Uri url =
                                Uri.parse('http://blog.tineaine.cn');
                            await launchUrl(url);
                          },
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedSafe,
                          tooltip: "安全中心",
                          onPressed: () => {},
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedCode,
                          tooltip: "代码视图",
                          onPressed: () => {
                            setState(() {
                              isCodeview = !isCodeview;
                            })
                          },
                        ),
                        // 中间空间扩展
                        Expanded(child: Container()),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedSetting07,
                          tooltip: "系统设置",
                          onPressed: () => {},
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedMessage01,
                          tooltip: "系统消息",
                          onPressed: () => {},
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedPictureInPictureExit,
                          tooltip: "返回主页",
                          onPressed: () => {
                            windowManager.unmaximize(),
                            windowManager.setSize(const Size(800, 600)),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            )
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
