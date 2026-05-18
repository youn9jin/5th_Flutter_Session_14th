import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cart_app/main.dart';

void main() {
  testWidgets(
    '추가 흐름: + 누르면 카드 라벨이 ✓ 담김으로 바뀌고 스낵바가 뜬다',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MusicApp());

      expect(find.text('이 화면의 플레이리스트: 0곡'), findsOneWidget);
      expect(find.text('+ 추가'), findsWidgets);

      await tester.tap(find.text('+ 추가').first);
      await tester.pump();

      expect(find.text('소문의 낙원이 플레이리스트에 추가됐습니다'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('이 화면의 플레이리스트: 1곡'), findsOneWidget);
      expect(find.text('✓ 담김'), findsOneWidget);
    },
  );

  testWidgets(
    '제거 흐름: 플레이리스트에서 X 누르면 제거되지만 노래 탭 카드는 ✓ 담김 유지 (의도된 버그)',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MusicApp());

      await tester.tap(find.text('+ 추가').first);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.queue_music_outlined));
      await tester.pumpAndSettle();

      expect(find.text('소문의 낙원'), findsOneWidget);
      expect(find.text('1곡'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      expect(find.text('플레이리스트가 비어있어요'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.music_note_outlined));
      await tester.pumpAndSettle();

      expect(find.text('✓ 담김'), findsOneWidget);
      expect(find.text('이 화면의 플레이리스트: 1곡'), findsOneWidget);
    },
  );
}
