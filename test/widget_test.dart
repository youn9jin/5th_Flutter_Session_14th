import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cart_app/main.dart';

void main() {
  testWidgets(
    '의도된 버그: 상품 탭에서 담아도 장바구니 탭에는 반영되지 않는다',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CartApp());

      expect(find.text('상품 목록'), findsOneWidget);
      expect(find.text('이 화면의 장바구니에 담긴 상품: 0개'), findsOneWidget);

      await tester.tap(find.text('담기').first);
      await tester.pumpAndSettle();

      expect(find.text('이 화면의 장바구니에 담긴 상품: 1개'), findsOneWidget);
      expect(find.text('담김'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
      await tester.pumpAndSettle();

      expect(find.text('장바구니가 비어 있어요'), findsOneWidget);
    },
  );
}
