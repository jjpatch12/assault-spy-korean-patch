# Assault Spy 한국어 패치

Assault Spy 일본어 슬롯을 교체하는 비공개 한국어 패치입니다. 현재 배포 버전은 **v8.1**입니다.

## 다운로드 및 설치

저장소의 **Releases → v8.1**에서 `AssaultSpy_KoreanPatch_v8.1.zip`을 내려받습니다.

1. ZIP 전체를 압축 해제합니다.
2. 게임을 완전히 종료합니다.
3. `AssaultSpy_KoreanPatch_Installer.bat`을 실행합니다.
4. 게임 폴더를 자동으로 찾지 못하면 `Assault Spy` 최상위 폴더를 입력합니다.

설치기는 기존 한국어 PAK을 `KoreanPatch_Backup/BAT_날짜-시간`에 백업하고, 설치 파일의 SHA-256을 확인한 뒤 적용합니다. 실제 PAK은 숨김 `.patch_data` 폴더에 들어 있으며 설치 후 게임 폴더에서도 숨김 속성으로 설정됩니다.

자세한 범위와 한계는 [PATCH_SCOPE_KO.md](PATCH_SCOPE_KO.md)를 확인하세요.

## 구성

- 한국어 폰트 PAK
- 전체 대사 PAK
- 대사 UI·자막 레이아웃 보완 PAK
- 설정·메뉴·전투 결과·로딩 이미지·잔여 UI 보완 PAK

이 저장소는 비공개 배포 및 개인 테스트용입니다. 패치 ZIP은 Git 이력에 직접 넣지 않고 비공개 릴리스 자산으로 제공합니다.

## v8.1 ZIP 무결성

`AssaultSpy_KoreanPatch_v8.1.zip`

SHA-256: `A469F5167E81074C15712C72DEB2D84D90A612EF1FAC954EF2CDDA2F6833550B`
