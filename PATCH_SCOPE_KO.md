# 패치 범위 v8.1

## 포함 범위

- 일본어 언어 슬롯을 이용한 한국어 표시
- 한글 글리프와 UI용 한국어 폰트
- 아사루·아멜리아 루트의 추출 대사 및 자막
- 타이틀, 세이브 선택, 일시정지, 설정, 조작 안내
- 스킬 상점, 스킬 설명, 튜토리얼, 전투평가, 보상 및 모드 해금 안내
- 난이도와 게임패드 버튼 표시명
- 캐릭터 소개 등 로딩 이미지 8장
- 소형 전투 결과 HUD의 `전투 결과 / 시간 / 점수 / 피해량 / 등급` 번역과 제목 겹침 보정
- `도장 모드` Tab 안내 번역 및 체력 UI와 겹치지 않도록 위치 보정
- 잘못된 문자열 인코딩 및 대사 하단 잘림 보완

## 조사·검증 범위

- 게임 패키지 헤더 13,881개 조사
- 텍스트 관련 후보 패키지 753개 분류
- DataTable 39개, 6,312행 조사
- 표시용 필드 8,765곳 점검
- 한국어로 바꿔야 하는 DataTable 일본어 표시 필드 잔여 0건
- DataTable 밖 하드코딩 UI 및 게임 상태 표시 434곳 추가 번역
- 최종 설정/UI PAK의 자산 43개와 엔트리 86개 재파싱·재추출 검증
- 설치기 내부 PAK 4개와 설치 결과에 대한 SHA-256 검증

## 원문 유지 및 제외 범위

- 요청에 따라 `Checkpoint`, `Loading`은 원본 영문 유지
- 게임 동작에 쓰이는 내부 자산명, Blueprint 식별자, 비교용 enum, 다른 언어 슬롯은 원문 유지
- 로고, 홍보 영상, 일부 튜토리얼 그림에 박힌 영문은 한국어화 범위에서 제외
- `Next`, `In Air` 등 일부 이미지형 영문 표시가 남을 수 있음
- 모든 해상도와 모든 플레이 구간의 실기 검증을 완료했다는 의미는 아님

따라서 대사·메뉴·설정·주요 게임 UI는 한국어화했지만, 게임에 포함된 모든 영상·텍스처·내부 문자열까지 100% 한국어로 바꾼 패치는 아닙니다.

## 설치 파일

설치기는 다음 네 파일을 적용합니다.

- `ASSAULT_SPY-WindowsNoEditor_KoreanFont_P.pak`
- `ASSAULT_SPY-WindowsNoEditor_KoreanDialogue_P.pak`
- `ASSAULT_SPY-WindowsNoEditor_KoreanDialogueUIFix_P.pak`
- `ASSAULT_SPY-WindowsNoEditor_KoreanSettings_P.pak`

게임 원본 `ASSAULT_SPY-WindowsNoEditor.pak`은 수정하거나 교체하지 않습니다.
