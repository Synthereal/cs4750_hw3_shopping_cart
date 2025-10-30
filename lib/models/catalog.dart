import 'package:flutter/material.dart';

/// Immutable catalog of items available in the store.
class CatalogModel {
  // A small deterministic list of names for demo purposes.
  static const List<String> _itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Inheritance',
    'Encapsulation',
    'Polymorphism',
    'Widget Tree',
    'State Machine',
    'Observer',
    'Decorator',
  ];

  Item getById(int id) {
    final name = _itemNames[id % _itemNames.length];
    // Use a simple palette variation based on id.
    final color = Colors.primaries[id % Colors.primaries.length];
    // Deterministic price just for the sample.
    final price = (id % 10 + 1) * 42;
    return Item(id: id, name: name, color: color, price: price);
  }

  Item getByPosition(int position) => getById(position);
}

class Item {
  final int id;
  final String name;
  final Color color;
  final int price;

  const Item({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
  });
}
