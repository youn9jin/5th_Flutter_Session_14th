# 🎵 Flutter 플레이리스트 앱 — setState vs Riverpod

Flutter 상태관리 학습을 위한 데모 앱입니다.  
**같은 앱을 두 가지 방식으로 구현해 차이를 직접 비교합니다.**

---

## 브랜치 구성

| 브랜치 | 설명 |
|---|---|
| `main` | setState 버전 — 데이터 불일치 버그 있음 |
| `riverpod` | Riverpod 버전 — 세 곳 모두 실시간 동기화 |

---

## 시작하기

```bash
# setState 버전
git clone [레포 URL]
flutter pub get
flutter run

# Riverpod 버전
git checkout riverpod
flutter pub get
flutter run
```

---

## 테스트 시나리오

### main 브랜치 (setState)

1. 앱 실행 → 노래 탭 시작
2. **소문의 낙원** "+ 추가" 탭
   - 카드가 "✓ 담김"으로 변경
   - 하단 뱃지 **1** 표시
   - 스낵바 "소문의 낙원이 플레이리스트에 추가됐습니다"
3. 플레이리스트 탭으로 이동
   - 소문의 낙원 목록에 보임
   - 하단 "총 곡 수 1곡"
4. X 버튼으로 삭제
   - 플레이리스트 비어있음
   - 뱃지 사라짐
5. 다시 노래 탭으로 이동
   - 소문의 낙원 카드 **여전히 "✓ 담김"** ← 🐛 버그
   - 다시 추가 불가능

### riverpod 브랜치 (Riverpod)

1~4단계 동일
5. 다시 노래 탭으로 이동
   - 소문의 낙원 카드 **"+ 추가"로 복구** ✅
   - 다시 추가 가능

---
## 기술 스택

- Flutter 3.x
- Riverpod 2.6.1 (`riverpod` 브랜치)
- Material 3

---

## 샘플 데이터

2026년 5월 멜론 차트 기준

| 곡명 | 아티스트 | 장르 |
|---|---|---|
| 소문의 낙원 | AKMU | 발라드 |
| RED | CORTIS | 팝 |
| It's Me | 아일릿 | 팝 |
| 기쁨, 슬픔, 아름다운 마음 | AKMU | 발라드 |
| RUDE! | Hearts2Hearts | 댄스 |
| 캐치 캐치 | 최예나 | 댄스 |
