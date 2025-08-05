abstract class ItemDataSource {
  Future<List<String>> fetchItems();
}

class MockItemDataSourceImpl implements ItemDataSource {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Future<List<String>> fetchItems() async {
    await Future.delayed(const Duration(seconds: 3));
    return items;
  }
}
