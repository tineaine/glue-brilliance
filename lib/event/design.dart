// 保存事件
class SaveEvent {
  // 请求来源（codeview,confview,mindview）
  SaveEvent(this.types);

  final String types;
}

// 撤销事件
class UndoEvent {
  UndoEvent(this.types);

  final String types;
}

// 重做事件
class RedoEvent {
  RedoEvent(this.types);

  final String types;
}

// 刷新事件
class RefreshEvent {
  RefreshEvent(this.types);

  final String types;
}

// 运行事件
class RunEvent {
  RunEvent();
}