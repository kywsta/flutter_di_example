import 'package:flutter/widgets.dart';
import 'package:flutter_di_example/provider/item_service.dart';

class ItemList extends ChangeNotifier {
  final ItemService itemService;

  final List<String> _items = [];

  bool _isLoading = false;

  ItemList(this.itemService) {
    _fetchItems();
  }

  List<String> get items => _items;

  bool get isLoading => _isLoading;

  void _fetchItems() async {
    _isLoading = true;
    notifyListeners();

    final items = await itemService.fetchItems();
    _items.addAll(items);
    _isLoading = false;
    notifyListeners();
  }
}
