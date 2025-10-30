import 'package:flutter/foundation.dart';
import 'catalog.dart';

class CartModel extends ChangeNotifier {
  late CatalogModel _catalog;
  CatalogModel get catalog => _catalog;
  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    notifyListeners();
  }

  final List<int> _itemIds = [];

  List<Item> get items => _itemIds.map(_catalog.getById).toList();

  int get totalPrice => items.fold(0, (sum, item) => sum + item.price);

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }

  bool contains(Item item) => _itemIds.contains(item.id);

  // NEW: clear the entire cart
  void clear() {
    _itemIds.clear();
    notifyListeners();
  }
}
