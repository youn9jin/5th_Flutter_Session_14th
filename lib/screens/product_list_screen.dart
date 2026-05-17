import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  static const List<Product> _products = [
    Product(id: 1, name: '무선 이어폰', price: 29000),
    Product(id: 2, name: '기계식 키보드', price: 89000),
    Product(id: 3, name: '마우스 패드', price: 12000),
    Product(id: 4, name: 'USB 허브', price: 34000),
    Product(id: 5, name: '웹캠', price: 67000),
  ];

  // 이 화면만의 독립적인 장바구니 상태.
  // CartScreen에는 절대 공유되지 않는다 — 이게 버그의 핵심.
  final List<Product> _cartItems = [];

  void _addToCart(Product product) {
    final alreadyInCart = _cartItems.any((item) => item.id == product.id);
    if (alreadyInCart) return;

    setState(() {
      _cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              '이 화면의 장바구니에 담긴 상품: ${_cartItems.length}개',
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
                    _cartItems.any((item) => item.id == product.id);
                return ProductCard(
                  product: product,
                  isInCart: isInCart,
                  onAddToCart: () => _addToCart(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
