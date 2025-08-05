import 'package:flutter/widgets.dart';
import 'package:flutter_di_example/get_it/item_repository.dart';

class ItemList extends ChangeNotifier {
  final ItemRepository itemRepository;

  final List<String> _items = [];

  bool _isLoading = false;

  ItemList(this.itemRepository) {
    _fetchItems();
  }

  List<String> get items => _items;

  bool get isLoading => _isLoading;

  void _fetchItems() async {
    _isLoading = true;
    notifyListeners();

    final items = await itemRepository.fetchItems();
    _items.addAll(items);
    _isLoading = false;
    notifyListeners();
  }
}
