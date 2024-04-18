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

<details>
<summary>드래그앤드랍</summary>

## 🎯주요 작업

- [x]  피드백 해결
- [x]  UITextView placeholder 구현
- [x]  카드 이동

## 📚학습 키워드

iOS 앱에서 사용자가 데이터를 드래그 앤 드롭할 수 있게, 데이터의 읽기와 쓰기를 위해 ‘NSItemProvider’를 통해 쉽게 전송하고자 함.

`writableTypeIdentifiersForItemProvider` :ToDoCard가 제공할 수 있는 데이터 타입을 나타낸다.

kUTTypeData를 사용하여 일반 데이터 타입을 나타냄.

kUTTypeData??? →Uniform Type Identifier (UTI) 시스템 일부로서, iOS와 macOS에서 데이터의 일반적인 바이너리 형식을 나타낸다. UTI는 파일, 폴더 등 같은 항목의 타입을 식별하는데 사용되는 표준화 방식임.

`loadData(withTypeIdentifier:forItemProviderCompletionHandler:)` **:** 외부로 데이터를 제공할 때 호출

TodoCard 인스턴스를 JSON데이터로 인코딩하여 제공한다. 인코딩 성공, 실패시에 각각 완료핸들러, 에러를 전달함

반대로

`readableTypeIdentifiersForItemProvider` : ToDoCard가 읽을 수 있는 데이터 타입을 나타낸다.

`object(withItemProviderData:typeIdentifier` **:** 외부에서  제공된 데이터를 사용하여 인스턴스를 생성한다.

### ToDoCard를 구조체에서 클래스로 바꾸고, 프로토콜을 채택한 이유는? 드래그앤드롭 기능 구현할 때 NSItemProvider 를 통해 데이터를 교환하기 위해서임!!!!

## 💻고민과 해결

### EditView에서 비활성화될때 okButton을 회색이 아닌, 흰색으로 바꾸고 싶은데 되지가 않습니다.

[ 해결하지 못함 ] nomal일 때, setTitleColor를 red로 했는데 적용이 안되는 것을 보아 스토리보드에서 만져야 하는지 감이 안잡힙니다. 그런데 비활성화, 활성화할 때 배경색을 커스텀하는 것은 되었는데, 왜 안되는지 도통 모르겠습니다

### 드래그 앤 드롭 기능

MainViewController가 CardListViewController 3개를 가지고 있어서 Main뷰컨트롤러가 관리하도록 의도함.

드래그가 시작될 때 

## 🤔결과

![드래그앤드랍-미완성](https://github.com/codesquad-members-2024/swift-todo/assets/104732020/01196098-2d96-4ed9-a2b7-6c62685a5791)

## 📚추가학습

**테이블 뷰 -> 테이블 뷰 drag and drop**

https://djgmd1021.tistory.com/143

</div>
</details>
