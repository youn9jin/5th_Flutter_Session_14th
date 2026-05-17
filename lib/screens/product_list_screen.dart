import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  static const List<Product> _products = [
    Product(id: 1, name: '무선 이어폰', price: 29000),
    Product(id: 2, name: '기계식 키보드', price: 89000),
    Product(id: 3, name: '마우스 패드', price: 12000),
    Product(id: 4, name: 'USB 허브', price: 34000),
    Product(id: 5, name: '웹캠', price: 67000),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 목록'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '이 화면의 장바구니에 담긴 상품: ${cartItems.length}개',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                final isInCart =
                    cartItems.any((item) => item.id == product.id);
                return ProductCard(
                  product: product,
                  isInCart: isInCart,
                  onAddToCart: () =>
                      ref.read(cartProvider.notifier).addToCart(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
