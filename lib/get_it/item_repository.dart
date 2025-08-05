import 'package:flutter_di_example/get_it/item_data_source.dart';

abstract class ItemRepository {
  final ItemDataSource itemDataSource;

  ItemRepository({required this.itemDataSource});

  Future<List<String>> fetchItems();
}

class ItemRepositoryImpl extends ItemRepository {
  ItemRepositoryImpl({required super.itemDataSource});

  @override
  Future<List<String>> fetchItems() async {
    return itemDataSource.fetchItems();
  }
}
