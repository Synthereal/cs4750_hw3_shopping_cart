import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/catalog.dart';
import '../models/cart.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            tooltip: 'Cart',
          ),
        ],
      ),
      body: const _CatalogList(),
    );
  }
}

class _CatalogList extends StatelessWidget {
  const _CatalogList();

  @override
  Widget build(BuildContext context) {
    // Just generate a long-ish list.
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        final item = context.read<CatalogModel>().getByPosition(index);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: _CatalogListItem(item: item),
        );
      },
    );
  }
}

class _CatalogListItem extends StatelessWidget {
  final Item item;
  const _CatalogListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final alreadyInCart = cart.contains(item);

    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundColor: item.color),
        title: Text(item.name),
        subtitle: Text('\$${item.price}'),
        trailing: ElevatedButton.icon(
          onPressed: alreadyInCart ? null : () => cart.add(item),
          icon: const Icon(Icons.add_shopping_cart),
          label: Text(alreadyInCart ? 'In Cart' : 'Add'),
        ),
      ),
    );
  }
}
