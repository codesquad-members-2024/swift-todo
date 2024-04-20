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

<details>
<summary>Context Menu</summary>

## 🎯주요 작업

- [x]  ContextMenu
    - [x]  완료한 일로 이동
    - [x]  수정하기
    - [x]  삭제하기
        - [x]  Swipe Delete

## 📚학습 키워드

### Context Menu

사용자가 앱 내의 특정 요소를 3D Touch제스처를 통해 접근할 수 있는 메뉴이다.

iOS 13부터 직관적이고, 접근성이 높은 상호작용을 가능하게 되었음.

지금 사용하는 UIKit에서 `UIContextMenuInteraction` 를 사용하여 컨텍스트 메뉴를 구현가능

### 3D Touch

화면을 누르는 힘의 강도를 감지하여 다양한 기능을 실행할 수 있게 해주는 상호작용 기능

화면 아래에 있는 압력 감지 센서를 통해 실행됨

### Squash & Merger

Squash는 여러개 커밋을 하나로 합친다. Squash 자체가 으깨다, 짓누르다 뜻을 가진다.

병합할 브랜치의 모든 커밋을 Squash한 새로운 커밋으로 Base 브랜치에 추가하는 방식

### Swipe Delete

```swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let card = self.cardManager.card(for: self.cardStatus, at: indexPath.row) else { return }
                // 배열에서 indexPath.row에 해당하는 값 제거하기       
        self.cardManager.removeCard(by: card.id)
        // 해당 cell을 tableview에서 없애기(UI적 요소)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
```

## 💻고민과 해결

### 수정하기 기능 구현과정에서 `Thread 1: Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value`  에러가 발생

 `loadViewIfNeeded()` 에 대해 공부하면서 문제를 해결 할 수 있었다.

뷰컨트롤러의 뷰가 로드되기 전에는 editView 프로퍼티가 아직 생성되지 않아서 EditViewController에서 editView를 직접 참조하려고 할 때, nil을 참조하게 되어서 에러가 발생되었다. 

그래서 loadViewIfNeeded() 사용해서 뷰컨트롤러가 뷰를 즉시 로드를 강제하여서, viewDidLoad()가 호출될 때까지 기다리지 않고 준비된 상태로 보장한다.

첫번째로 하드코딩으로 구현해서, 두번째로 뷰 컨트롤러의 생명주기를 이해를 완전히 못해서 발생한 에러라고 생각합니다. 다음에는 뷰 로드 → 초기화를 매끄럽게 구현하는 방법을 우선적으로 생각해봐야겠다는 고민을 하게 되었습니다.

## 🤔결과
![4주차결과](https://github.com/codesquad-members-2024/swift-todo/assets/104732020/ae79c117-1e01-46c9-ab37-b8113db3aa8b)

</div>
</details>
