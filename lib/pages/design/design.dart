import 'package:brilliance/common/title_bar.dart';
import 'package:brilliance/event/design.dart';
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
import 'package:brilliance/pages/design/views/blueprint_view.dart';
import 'package:brilliance/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../common/button/menu_button.dart';
import '../../event/event.dart';
import 'views/code_view.dart';
import 'views/light_view.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  // 突出颜色
  Color subColor = const Color.fromARGB(255, 0, 127, 255);

  // 禁用颜色
  Color disableColor = const Color.fromARGB(255, 150, 150, 150);

  String currentProjectPath = "project1";

  // String currentBlueprintPath = "./test.json";

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

  GlobalKey<BlueprintViewState> blueprintViewKey =
      GlobalKey<BlueprintViewState>();
  GlobalKey<LightViewState> confViewKey = GlobalKey<LightViewState>();
  GlobalKey<CodeviewState> codeViewKey = GlobalKey<CodeviewState>();

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
                    children: makeMenu("l"),
                  ),
                ),
                // 画布
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
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
                                        child:
                                            Container(child: getRightContent()))
                                    : Container(),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 500,
                            margin: const EdgeInsets.only(top: 15),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(180, 225, 225, 225),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
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
                                        ? subColor
                                        : Colors.black,
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
                                        ? subColor
                                        : Colors.black,
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
                                        ? subColor
                                        : Colors.black,
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
                                        ? subColor
                                        : Colors.black,
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
                                        ? subColor
                                        : Colors.black,
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
                                      eventBus.fire(RefreshEvent(currentView)),
                                    },
                                    color: Colors.black87,
                                  ),

                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData: HugeIcons
                                        .strokeRoundedArrowTurnBackward,
                                    tooltip: "回退(Ctrl/Command + Z)",
                                    onPressed: () => {
                                      eventBus.fire(UndoEvent(currentView)),
                                    },
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData:
                                        HugeIcons.strokeRoundedArrowTurnForward,
                                    tooltip: "前进(Ctrl/Command + Shift + Z)",
                                    onPressed: () => {
                                      eventBus.fire(RedoEvent(currentView)),
                                    },
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData:
                                        HugeIcons.strokeRoundedDownloadSquare02,
                                    tooltip: "保存(Ctrl/Command + S)",
                                    onPressed: () => {
                                      eventBus.fire(SaveEvent(currentView)),
                                    },
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 10),
                                  QMenuButton(
                                    iconData: HugeIcons.strokeRoundedStartUp02,
                                    tooltip: "运行(Ctrl/Command + R)",
                                    onPressed: () => {
                                      eventBus.fire(RunEvent()),
                                    },
                                    color: Colors.black87,
                                  ),
                                ]),
                          )
                          // 顶部工具
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
                      children: makeMenu("r"),
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
        return LightView();
      case "codeview":
        return Codeview();
      default:
        return BlueprintView();
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

  makeMenu(String makefor) {
    List<MenuIconButtonStatus> ltnames = [
      MenuIconButtonStatus(
          name: "项目",
          key: "project",
          iconData: HugeIcons.strokeRoundedFolder01,
          onPressed: () => {}),
      MenuIconButtonStatus(
          name: "同步",
          key: "sync",
          iconData: HugeIcons.strokeRoundedFolderSync,
          onPressed: () => {}),
      MenuIconButtonStatus(
          name: "组件",
          key: "comp",
          iconData: HugeIcons.strokeRoundedNeuralNetwork,
          onPressed: () => {}),
      MenuIconButtonStatus(
          name: "结构",
          key: "struct",
          iconData: HugeIcons.strokeRoundedStructureFolderCircle,
          onPressed: () => {}),
      // 扩展，如果key为"expanded"
      MenuIconButtonStatus(
          name: "",
          key: "expanded",
          iconData: HugeIcons.strokeRoundedStructureFolderCircle,
          onPressed: () => {}),

      MenuIconButtonStatus(
          name: "控制台",
          key: "console",
          iconData: HugeIcons.strokeRoundedGreaterThanSquare,
          onPressed: () => {}),
      MenuIconButtonStatus(
          name: "问题",
          key: "debug",
          iconData: HugeIcons.strokeRoundedBug02,
          onPressed: () => {}),
      MenuIconButtonStatus(
          name: "引擎",
          key: "engine",
          iconData: HugeIcons.strokeRoundedChip,
          onPressed: () => {}),
      MenuIconButtonStatus(
          name: "消息",
          key: "message",
          iconData: HugeIcons.strokeRoundedMessage01,
          onPressed: () => {}),
    ];
    List<MenuIconButtonStatus> rtnames = [
      MenuIconButtonStatus(
          name: "属性",
          key: "attr",
          iconData: HugeIcons.strokeRoundedSettings05,
          onPressed: () => {}),
      MenuIconButtonStatus(
          name: "蓝图",
          key: "blueprint",
          iconData: HugeIcons.strokeRoundedCompass01,
          onPressed: () => {
                setState(() {
                  currentView = "blueprint";
                  canvasTool = "cursor";
                })
              }),
      MenuIconButtonStatus(
          name: "轻码",
          key: "confview",
          iconData: HugeIcons.strokeRoundedCodeSquare,
          onPressed: () => {
                setState(() {
                  currentView = "confview";
                  canvasTool = "none";
                })
              }),
      MenuIconButtonStatus(
          name: "代码",
          key: "codeview",
          iconData: HugeIcons.strokeRoundedCode,
          onPressed: () => {
                setState(() {
                  currentView = "codeview";
                  canvasTool = "none";
                })
              }),
      MenuIconButtonStatus(
          name: "AI",
          key: "ai",
          iconData: HugeIcons.strokeRoundedAiInnovation02,
          onPressed: () => {}),

      // 扩展，如果key为"expanded"
      MenuIconButtonStatus(
          name: "",
          key: "expanded",
          iconData: HugeIcons.strokeRoundedStructureFolderCircle,
          onPressed: () => {}),

      MenuIconButtonStatus(
          name: "设置",
          key: "setting",
          iconData: HugeIcons.strokeRoundedSetting07,
          onPressed: () => {}),
      MenuIconButtonStatus(
        name: "市场",
        key: "extension",
        iconData: HugeIcons.strokeRoundedShopSign,
        onPressed: () async {
          Uri url = Uri.parse('http://blog.tineaine.cn');
          await launchUrl(url);
        },
      ),
      MenuIconButtonStatus(
          name: "退出",
          key: "exit",
          iconData: HugeIcons.strokeRoundedPictureInPictureExit,
          onPressed: () => {
                windowManager.unmaximize(),
                windowManager.setSize(const Size(800, 600)),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                )
              }),
    ];
    List<Widget> menu = [];

    switch (makefor) {
      case "l":
        for (MenuIconButtonStatus button in ltnames) {
          if (button.key == "expanded") {
            menu.add(Expanded(child: Container()));
          } else {
            menu.add(QMenuButton(
              tooltip: button.name,
              isSelected: getIsSelect(button.key),
              selectedColor: subColor,
              onPressed: () => {
                setState(() {
                  changeStatus(button.key);
                  button.onPressed();
                })
              },
              iconData: button.iconData,
            ));
            // 底部间隔
            menu.add(SizedBox(height: 10));
          }
        }
        break;
      case "r":
        for (MenuIconButtonStatus button in rtnames) {
          if (button.key == "expanded") {
            menu.add(Expanded(child: Container()));
          } else {
            menu.add(QMenuButton(
              tooltip: button.name,
              isSelected: getIsSelect(button.key),
              selectedColor: subColor,
              onPressed: () => {
                setState(() {
                  changeStatus(button.key);
                  button.onPressed();
                })
              },
              iconData: button.iconData,
            ));
            // 底部间隔
            menu.add(SizedBox(height: 10));
          }
        }
        break;
    }

    return menu;
  }

  bool getIsSelect(String key) {
    if ((showLeftContent && leftTool == key) ||
        (rightTool == key && showRightContent) ||
        (bottomTool == key && showBottom) ||
        (currentView == key)) {
      return true;
    } else {
      return false;
    }
  }

  changeStatus(String name) {
    List<String> lnames = ["project", "comp", "sync", "struct"];
    List<String> bnames = ["console", "debug", "engine", "message"];
    List<String> rnames = ["attr", "ai"];

    if (lnames.contains(name)) {
      if (leftTool == name) {
        showLeftContent = !showLeftContent;
      } else if (showLeftContent) {
        leftTool = name;
      } else {
        leftTool = name;
        showLeftContent = !showLeftContent;
      }
    } else if (rnames.contains(name)) {
      if (rightTool == name) {
        showRightContent = !showRightContent;
      } else if (showRightContent) {
        rightTool = name;
      } else {
        rightTool = name;
        showRightContent = !showRightContent;
      }
    } else if (bnames.contains(name)) {
      if (bottomTool == name) {
        showBottom = !showBottom;
      } else if (showBottom) {
        bottomTool = name;
      } else {
        bottomTool = name;
        showBottom = !showBottom;
      }
    }
  }
}

class MenuIconButtonStatus {
  String name;
  String key;
  IconData iconData;
  VoidCallback onPressed;

  MenuIconButtonStatus({
    required this.name,
    required this.key,
    required this.iconData,
    required this.onPressed,
  });
}
