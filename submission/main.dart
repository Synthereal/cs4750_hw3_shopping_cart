import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/catalog.dart';
import 'models/cart.dart';
import 'screens/catalog.dart';
import 'screens/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Catalog is read-only app data.
        Provider<CatalogModel>(create: (_) => CatalogModel()),
        // Cart depends on Catalog; use a ProxyProvider to inject it.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (_) => CartModel(),
          update: (_, catalog, cart) => cart!..catalog = catalog,
        ),
      ],
      child: MaterialApp(
        title: 'Provider Shopper (Simple)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        initialRoute: '/',
        routes: {
          '/': (_) => const MyCatalog(),
          '/cart': (_) => const MyCart(),
        },
      ),
    );
  }
}
