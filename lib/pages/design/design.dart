import 'package:brilliance/common/canvas/canvas.dart';
import 'package:brilliance/common/titlebar.dart';
import 'package:brilliance/pages/design/panel/ai.dart';
import 'package:brilliance/pages/design/panel/attr.dart';
import 'package:brilliance/pages/design/panel/bug.dart';
import 'package:brilliance/pages/design/panel/comp.dart';
import 'package:brilliance/pages/design/panel/console.dart';
import 'package:brilliance/pages/design/panel/engine.dart';
import 'package:brilliance/pages/design/panel/message.dart';
import 'package:brilliance/pages/design/panel/project.dart';
import 'package:brilliance/pages/design/panel/struct.dart';
import 'package:brilliance/pages/design/panel/sync.dart';
import 'package:brilliance/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../common/button/menuButton.dart';
import 'views/codeview.dart';
import 'views/confview.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  @override
  void initState() {
    windowManager.maximize();
    windowManager.setMinimumSize(const Size(800, 500));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String currentView = "blueprint";

  // 显示底部区域
  bool showBottom = false;

  // 显示顶部区域（默认显示）
  bool showTop = true;

  // 显示左侧区域
  bool showLeftContent = false;

  // 显示右侧区域
  bool showRightContent = false;

  // 当前顶部工具（当前画布工具）
  // cursor（选择）、hand（移动）、link（链接）、comp（组件）、note（注释/笔记）
  String canvasTool = "cursor";

  // 当前底部工具
  // console（控制台）、warning（错误提示）、engine（引擎控制）、message（系统消息）
  String bottomTool = "none";

  // 当前左测栏工具
  // project（项目）、sync（同步）、struct（结构）、comp（组件）
  String leftTool = "none";

  // 当前右侧栏工具
  // attr(组件属性）、ai(智能助手)
  String rightTool = "none";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Titlebar(),
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
                        tooltip: "项目",
                        isSelected: leftTool == "project",
                        onPressed: () => {
                          setState(() {
                            if (leftTool == "project") {
                              showLeftContent = !showLeftContent;
                            } else if (showLeftContent) {
                              leftTool = "project";
                            } else {
                              leftTool = "project";
                              showLeftContent = !showLeftContent;
                            }
                          })
                        },
                        iconData: HugeIcons.strokeRoundedFolder01,
                      ),
                      const SizedBox(height: 10),
                      // 项目
                      QMenuButton(
                        tooltip: "同步",
                        onPressed: () => {
                          setState(() {
                            if (leftTool == "sync") {
                              showLeftContent = !showLeftContent;
                            } else if (showLeftContent) {
                              leftTool = "sync";
                            } else {
                              leftTool = "sync";
                              showLeftContent = !showLeftContent;
                            }
                          })
                        },
                        iconData: HugeIcons.strokeRoundedFolderSync,
                      ),

                      const SizedBox(height: 10),
                      // 组件库
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedStructureFolderCircle,
                        tooltip: "结构",
                        onPressed: () => {
                          setState(() {
                            if (leftTool == "struct") {
                              showLeftContent = !showLeftContent;
                            } else if (showLeftContent) {
                              leftTool = "struct";
                            } else {
                              leftTool = "struct";
                              showLeftContent = !showLeftContent;
                            }
                          })
                        },
                      ),
                      const SizedBox(height: 10),
                      // 组件库
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedNeuralNetwork,
                        tooltip: "节点",
                        onPressed: () => {
                          setState(() {
                            if (leftTool == "comp") {
                              showLeftContent = !showLeftContent;
                            } else if (showLeftContent) {
                              leftTool = "comp";
                            } else {
                              leftTool = "comp";
                              showLeftContent = !showLeftContent;
                            }
                          })
                        },
                      ),
                      // 中间空间扩展
                      Expanded(child: Container()),

                      // 管理台
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedGreaterThanSquare,
                        tooltip: "控制台",
                        onPressed: () => {
                          setState(() {
                            if (bottomTool == "console") {
                              showBottom = !showBottom;
                            } else if (showBottom) {
                              bottomTool = "console";
                            } else {
                              bottomTool = "console";
                              showBottom = !showBottom;
                            }
                          })
                        },
                      ),
                      const SizedBox(height: 10),
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedBug02,
                        tooltip: "暂无错误与警告",
                        // color: const Color.fromARGB(255, 255, 174, 0),
                        onPressed: () => {
                          setState(() {
                            if (bottomTool == "debug") {
                              showBottom = !showBottom;
                            } else if (showBottom) {
                              bottomTool = "debug";
                            } else {
                              bottomTool = "debug";
                              showBottom = !showBottom;
                            }
                          })
                        },
                      ),
                      const SizedBox(height: 10),
                      // 引擎控制
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedChip,
                        tooltip: "引擎",
                        onPressed: () => {
                          setState(() {
                            if (bottomTool == "engine") {
                              showBottom = !showBottom;
                            } else if (showBottom) {
                              bottomTool = "engine";
                            } else {
                              bottomTool = "engine";
                              showBottom = !showBottom;
                            }
                          })
                        },
                      ),
                      const SizedBox(height: 10),
                      QMenuButton(
                        iconData: HugeIcons.strokeRoundedMessage01,
                        tooltip: "消息",
                        onPressed: () => {
                          setState(() {
                            if (bottomTool == "message") {
                              showBottom = !showBottom;
                            } else if (showBottom) {
                              bottomTool = "message";
                            } else {
                              bottomTool = "message";
                              showBottom = !showBottom;
                            }
                          })
                        },
                      ),
                    ],
                  ),
                ),
                // 画布
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // 画布
                          Container(
                            color: const Color.fromARGB(255, 250, 250, 250),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 左部空间
                                showLeftContent
                                    ? Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: getLeftContent(),
                                        ))
                                    : Container(),
                                // 这时设计视图区域
                                Expanded(
                                  flex: 6,
                                  child: getContent(),
                                ),
                                // 右侧空间
                                showRightContent
                                    ? Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: getRightContent(),
                                          // color: Colors.black54
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
                          // 顶部工具
                          Container(
                            height: 40,
                            width: 500,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(150, 225, 225, 225),
                                boxShadow: [
                                  // BoxShadow(
                                  //         color: Color.fromARGB(
                                  //             255, 239, 239, 239),
                                  //         blurRadius: 5,
                                  //         spreadRadius: 1,
                                  //         offset: Offset(0, 1))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromARGB(
                                            255, 239, 239, 239)))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  QMenuButton(
                                    iconData: HugeIcons.strokeRoundedCursor01,
                                    tooltip: "选择(Q)",
                                    disabled: currentView != "blueprint",
                                    onPressed: () => {
                                      setState(() {
                                        canvasTool = "cursor";
                                      })
                                    },
                                    color: canvasTool == "cursor"
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData:
                                        HugeIcons.strokeRoundedWavingHand01,
                                    tooltip: "拖动(空格)",
                                    disabled: currentView != "blueprint",
                                    onPressed: () => {
                                      setState(() {
                                        canvasTool = "hand";
                                      })
                                    },
                                    color: canvasTool == "hand"
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                  const SizedBox(width: 10),
                                  // 组件
                                  QMenuButton(
                                    iconData: HugeIcons
                                        .strokeRoundedDashboardSquareAdd,
                                    disabled: currentView != "blueprint",
                                    tooltip: "节点(E)",
                                    onPressed: () => {
                                      setState(() {
                                        canvasTool = "comp";
                                      })
                                    },
                                    color: canvasTool == "comp"
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData:
                                        HugeIcons.strokeRoundedStructureAdd,
                                    disabled: currentView != "blueprint",
                                    tooltip: "连接(R)",
                                    onPressed: () => {
                                      setState(() {
                                        canvasTool = "link";
                                      })
                                    },
                                    color: canvasTool == "link"
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData: HugeIcons.strokeRoundedNoteEdit,
                                    disabled: currentView != "blueprint",
                                    tooltip: "笔记(N)",
                                    onPressed: () => {
                                      setState(() {
                                        canvasTool = "note";
                                      })
                                    },
                                    color: canvasTool == "note"
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                  const SizedBox(width: 10),
                                  // 分割线
                                  Container(
                                    width: 1,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      left: BorderSide(
                                          color: Color.fromARGB(
                                              255, 220, 220, 220)),
                                    )),
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData: HugeIcons.strokeRoundedRecycle03,
                                    tooltip: "刷新(F5)",
                                    onPressed: () => {
                                      // TODO：调用画布的前进/还原
                                    },
                                    color: Colors.black87,
                                  ),

                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData: HugeIcons
                                        .strokeRoundedArrowTurnBackward,
                                    tooltip: "回退(Ctrl/Command + Z)",
                                    onPressed: () => {
                                      // TODO：调用画布的回退/撤销
                                    },
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData:
                                        HugeIcons.strokeRoundedArrowTurnForward,
                                    tooltip: "前进(Ctrl/Command + Shift + Z)",
                                    onPressed: () => {
                                      // TODO：调用画布的前进/还原
                                    },
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData:
                                        HugeIcons.strokeRoundedDownloadSquare02,
                                    tooltip: "保存(Ctrl/Command + S)",
                                    onPressed: () => {
                                      // TODO：调用画布的存储方法
                                    },
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData: HugeIcons.strokeRoundedStartUp02,
                                    tooltip: "运行(Ctrl/Command + R)",
                                    onPressed: () => {
                                      // TODO：调用画布的存储方法
                                    },
                                    color: Colors.black87,
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                    // 底部控制区域
                    showBottom
                        ? Expanded(
                            flex: 3,
                            child: Container(
                              child: getBottomContent(),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 250, 250, 250),
                                  border: Border(
                                      top: BorderSide(
                                          color: Color.fromARGB(
                                              255, 239, 239, 239)))),
                            ))
                        : Container()
                  ],
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
                          iconData: HugeIcons.strokeRoundedSettings05,
                          tooltip: "属性(P)",
                          onPressed: () => {
                            setState(() {
                              if (rightTool == "attr") {
                                showRightContent = !showRightContent;
                              } else if (showRightContent) {
                                rightTool = "attr";
                              } else {
                                rightTool = "attr";
                                showRightContent = !showRightContent;
                              }
                            })
                          },
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedCompass01,
                          tooltip: "蓝图(B)",
                          onPressed: () => {
                            setState(() {
                              currentView = "blueprint";
                              canvasTool = "cursor";
                            })
                          },
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedCodeSquare,
                          tooltip: "轻代码(S)",
                          onPressed: () => {
                            setState(() {
                              currentView = "confview";
                              canvasTool = "none";
                            })
                          },
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedCode,
                          tooltip: "代码(C)",
                          onPressed: () => {
                            setState(() {
                              currentView = "codeview";
                              canvasTool = "none";
                            })
                          },
                        ),

                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedAiInnovation02,
                          tooltip: "AI",
                          onPressed: () => {
                            setState(() {
                              if (rightTool == "ai") {
                                showRightContent = !showRightContent;
                              } else if (showRightContent) {
                                rightTool = "ai";
                              } else {
                                rightTool = "ai";
                                showRightContent = !showRightContent;
                              }
                            })
                          },
                        ),
                        // 中间空间扩展
                        Expanded(child: Container()),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedSetting07,
                          tooltip: "设置",
                          onPressed: () => {},
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedShopSign,
                          tooltip: "扩展",
                          onPressed: () async {
                            Uri url = Uri.parse('http://blog.tineaine.cn');
                            await launchUrl(url);
                          },
                        ),
                        const SizedBox(height: 10),
                        QMenuButton(
                          iconData: HugeIcons.strokeRoundedPictureInPictureExit,
                          tooltip: "退出",
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

  // 获取内容
  getContent() {
    switch (currentView) {
      case "confview":
        return Confview();
      case "codeview":
        return Codeview(
          filePath: './test.json',
        );
      default:
        return MainCanvas();
    }
  }

  // 获取左侧区域组件
  getLeftContent() {
    switch (leftTool) {
      case "project":
        return ProjectPanel();
      case "comp":
        return CompPanel();
      case "sync":
        return SyncPanel();
      case "struct":
        return StructPanel();
      default:
        return Container();
    }
  }

// 获取右侧区域组件
  getRightContent() {
    switch (rightTool) {
      case "attr":
        return AttrPanel();
      case "ai":
        return AiPanel();
      default:
        return Container();
    }
  }

// 获取底部区域组件
  getBottomContent() {
    switch (bottomTool) {
      case "message":
        return MessagePanel();
      case "console":
        return ConsolePanel();
      case "debug":
        return BugPanel();
      case "engine":
        return EnginePanel();
      default:
        return Container();
    }
  }
}
