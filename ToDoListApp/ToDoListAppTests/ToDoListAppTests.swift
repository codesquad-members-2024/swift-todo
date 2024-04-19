//
//  ToDoListAppTests.swift
//  ToDoListAppTests
//
//  Created by 조호근 on 4/8/24.
//

import XCTest
@testable import ToDoListApp

final class ToDoListAppTests: XCTestCase {
    var cardManager: CardManager!
    var testCard: ToDoCard!
    
    override func setUp() {
        super.setUp()
        
        testCard = ToDoCard(title: "Test Title", descriptionText: "Test Description", platform: "iOS")
        cardManager = CardManager()
        cardManager.addCard(testCard, with: .toDO)
    }
    
    override func tearDown() {
        cardManager = nil
        testCard = nil
        super.tearDown()
    }
    
    func testCardsForStatus() {
        let cards = cardManager.cards(for: .toDO)
        XCTAssertTrue(cards.contains { $0.id == testCard.id }, "카드 매니저가 올바른 상태의 카드를 반환해야 합니다.")
    }
    
    func testAddCard() {
        let newCard = ToDoCard(title: "New title", descriptionText: "New description", platform: "iOS")
        cardManager.addCard(newCard, with: .inProgress)
        XCTAssertEqual(cardManager.totalCount, 2, "카드 추가 후 카드 count가 일치해야 합니다.")
    }
    
    func testRemoveCard() {
        cardManager.removeCard(by: testCard.id)
        XCTAssertEqual(cardManager.totalCount, 0, "카드 제거 후 카드 count가 일치해야 합니다.")
    }
    
    func testFindCard() {
        let foundCard = cardManager[testCard.id]
        XCTAssertNotNil(foundCard, "ID로 카드를 검색했을 때 카드가 존재해야 합니다.")
        XCTAssertEqual(foundCard?.title, testCard.title, "찾아진 카드는 요청된 카드와 동일해야 합니다.")
    }
}
