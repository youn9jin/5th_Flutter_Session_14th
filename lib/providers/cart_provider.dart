import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

class CartNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() => const [];

  void addToCart(Product product) {
    final alreadyInCart = state.any((item) => item.id == product.id);
    if (alreadyInCart) return;

    state = [...state, product];
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.id != product.id).toList();
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<Product>>(
  () => CartNotifier(),
);
