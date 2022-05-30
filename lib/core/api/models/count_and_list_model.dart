class CountAndListModel<T> {
  final int count;
  final List<T> list;

  CountAndListModel({
    this.count = 0,
    required this.list,
  });
}
