//
//  CardManager.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/11/24.
//

import Foundation
import os

protocol CardManaging {
    var count: Int { get }
    func count(for status: CardStatus) -> Int
    func card(for status: CardStatus, at index: Int) -> ToDoCard?
    func addCard(_ card: ToDoCard)
    func removeCard(by id: UUID)
}

class CardManager: CardManaging {
    enum Notifications {
        static let NewCardAdded = Notification.Name("NewCardAdded")
    }
    
    private var cards: [ToDoCard]
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "CardManager")

    init(cards: [ToDoCard] = []) {
        self.cards = cards
    }
    
    var count: Int {
        return self.cards.count
    }
    
    func count(for status: CardStatus) -> Int {
        return cards.filter { $0.status == status }.count
    }
    
    func card(for status: CardStatus, at index: Int) -> ToDoCard? {
        let filteredCards = cards.filter { $0.status == status }
        guard index >= 0 && index < filteredCards.count else { return nil }
        return filteredCards[index]
    }
    
    func findCard(by id: UUID) -> ToDoCard? {
        return cards.first { $0.id == id }
    }
    
    func addCard(_ card: ToDoCard) {
        logger.log(level: .info, "[ 생성된 카드 ]: \(String(describing: card)). \n[ 총 cards 갯수 ]: \(self.cards.count + 1)")
        self.cards.append(card)
        NotificationCenter.default.post(name: Self.Notifications.NewCardAdded, object: nil, userInfo: ["newCard": card])
    }
    
    func removeCard(by id: UUID) {
        if let index = cards.firstIndex(where: { $0.id == id }) {
            cards.remove(at: index)
        }
    }
}
