enum ListViewStatusEnum {
  /// 没有数据
  noMore,

  /// 加载中
  loading,

  /// 刷新中
  refresh,

  /// 错误
  error,

  /// 完成
  complete,
}

/// 列表状态
class ListViewStatus {
  int page = 1;
  ListViewStatusEnum listStatus = ListViewStatusEnum.complete;
}
