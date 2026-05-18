import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cart_app/main.dart';

void main() {
  testWidgets(
    '의도된 버그: 노래 탭에서 추가해도 플레이리스트 탭은 비어 있다',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MusicApp());

      expect(find.text('노래'), findsWidgets);
      expect(find.text('이 화면의 플레이리스트: 0곡'), findsOneWidget);

      await tester
          .tap(find.byIcon(Icons.add_circle_outline).first);
      await tester.pumpAndSettle();

      expect(find.text('이 화면의 플레이리스트: 1곡'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      await tester.tap(find.byIcon(Icons.queue_music_outlined));
      await tester.pumpAndSettle();

      expect(find.text('플레이리스트가 비어있어요'), findsOneWidget);
    },
  );
}
