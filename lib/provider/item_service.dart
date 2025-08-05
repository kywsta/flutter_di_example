class ItemService {
  final _items = ['Item 1', 'Item 2', 'Item 3'];

  ItemService();

  Future<List<String>> fetchItems() async {
    await Future.delayed(const Duration(seconds: 3));
    return _items;
  }
}
