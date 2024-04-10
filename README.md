# swift-todo
iOS 네번째 프로젝트

<details>
<summary>UI 구성하기</summary>

## 🎯주요 작업

- [x]  스토리보드에서 작업하기 - 오토레이 아웃 적용하기
- [x]  카드 리스트 화면은 상단에 제목/배지/추가 버튼과 카드 목록을 표시하는 TableVIew 구성
    - [x]  배지는 현재 카드 개수를 표시
    - [x]  모서리가 없이 표시하고 숫자가 늘어나면 iOS 기본 배지처럼 가운데 영역길어짐
    - [x]  카드 셀은 본문 내용을 3줄까지만 표시
        - [x]  1줄 - 3줄까지 늘어나면 셀 높이도 같이 (self-resizing) 늘어나도록 구현

## 📚학습 키워드

### Anchor

영어로 `닻` 이라는 뜻인데, 쉽게 View에 닻을 내려서 고정시킨다고 생각

### **container view 사용 방법**

1. parentVC.addChild(childVC): 특정 ViewController를 현재 ViewController의 자식으로 설정
2. parentVC.view.addSubview(childView): 추가된 childVC의 View가 보일 수 있도록 맨 앞으로 등장하게 하는 것
3. childVC.didMove(toParent: parentVC) / willMove: childVC입장에서는 언제 parentVC에 추가되는지 모르기 때문에, childVC에게 추가 및 제거 되는 시점을 알려주는 것 (willMove / didMove: 추가되기 전, 추가된 후)

## 💻고민과 해결

### **Logging Error: Failed to initialize logging system. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables.에러발생**

[🧙‍♂️나의 해결] **`Product** -> **Scheme** -> **Edit Scheme → Arguments** 로 이동 -> **Arguments Passed On Launch** 에서 + 눌러서 아래와 같은 코드 입력 -> **Close** 클릭.`

### 네비게이션 스토리보드로 제목 커스텀하기

[🧙‍♂️나의 해결] 네비게이션바에 UIView 넣고 UILabel넣음

## 🤔결과
<img width="1077" alt="스크린샷 2024-04-10 오후 3 02 15" src="https://github.com/codesquad-members-2024/swift-todo/assets/104732020/9997f3ca-b0b6-44fa-8a9a-bc5a082154e8">

</div>
</details>
