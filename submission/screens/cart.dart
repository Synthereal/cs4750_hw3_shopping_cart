import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/cart.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  void _buyAndCelebrate(BuildContext context) {
    final cart = context.read<CartModel>();
    if (cart.items.isEmpty) return;

    // Fire confetti first so it renders while the UI clears.
    _confetti.play();

    // Clear cart immediately after purchase.
    cart.clear();

    // Optional toast to confirm.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thanks for your purchase!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('Your Cart')),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      leading: CircleAvatar(backgroundColor: item.color),
                      title: Text(item.name),
                      subtitle: Text('\$${item.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => cart.remove(item),
                        tooltip: 'Remove',
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Total: \$${cart.totalPrice}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: cart.items.isEmpty
                          ? null
                          : () => _buyAndCelebrate(context),
                      child: const Text('BUY'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Full-screen confetti overlay (non-interactive)
        IgnorePointer(
          ignoring: true,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 40,
              maxBlastForce: 20,
              minBlastForce: 5,
              gravity: 0.6,
              // Spread across the screen by placing at top center.
            ),
          ),
        ),
      ],
    );
  }
}
