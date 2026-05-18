import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cart_app/main.dart';

void main() {
  testWidgets(
    'playlistProvider로 세 곳이 같은 플레이리스트를 공유한다',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MusicApp()),
      );

      expect(find.text('이 화면의 플레이리스트: 0곡'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_circle_outline).first);
      await tester.pumpAndSettle();

      expect(find.text('이 화면의 플레이리스트: 1곡'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.queue_music_outlined));
      await tester.pumpAndSettle();

      expect(find.text('플레이리스트가 비어있어요'), findsNothing);
      expect(find.text('소문의 낙원'), findsOneWidget);
      expect(find.text('1곡'), findsWidgets);
    },
  );
}
