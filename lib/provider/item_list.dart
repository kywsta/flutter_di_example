
import 'package:flutter/widgets.dart';
import 'package:flutter_di_example/provider/item_service.dart';

class ItemList extends ChangeNotifier {
  final ItemService itemService;

  final List<String> _items = [];

  List<String> get items => _items;

  ItemList(this.itemService) {
    _fetchItems();
  }

  void _fetchItems() async {
    final items = await itemService.fetchItems();
    _items.addAll(items);
    notifyListeners();
  }
}