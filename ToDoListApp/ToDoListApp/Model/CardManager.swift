//
//  CardManager.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/11/24.
//

import Foundation
import os

protocol CardManaging {
    var totalCount: Int { get }
    func count(for status: CardStatus) -> Int
    func card(for status: CardStatus, at index: Int) -> ToDoCard?
    func addCard(_ card: ToDoCard, with status: CardStatus)
    func removeCard(by id: UUID)
}

class CardManager: CardManaging {
    enum Notifications {
        static let NewCardAdded = Notification.Name("NewCardAdded")
    }
    
    private var cards: [UUID: ToDoCard] = [:]
    private var statuses: [UUID: CardStatus] = [:]
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "CardManager")
    
    var totalCount: Int {
        return self.cards.count
    }
    
    subscript(id: UUID) -> ToDoCard? {
        return cards[id]
    }
    
    func count(for status: CardStatus) -> Int {
        return cards(for: status).count
    }
    
    func cards(for status: CardStatus) -> [ToDoCard] {
        return statuses.filter { $0.value == status }.compactMap { cards[$0.key] }
    }
    
    func card(for status: CardStatus, at index: Int) -> ToDoCard? {
        let filteredCards = cards(for: status)
        guard index >= 0 && index < filteredCards.count else { return nil }
        return filteredCards[index]
    }
    
    func addCard(_ card: ToDoCard, with status: CardStatus) {
        logger.log(level: .info, "[ 생성된 카드 ]: \(String(describing: card)). \n[ 총 cards 갯수 ]: \(self.cards.count + 1)")
        cards[card.id] = card
        statuses[card.id] = status
        NotificationCenter.default.post(name: Self.Notifications.NewCardAdded, object: nil, userInfo: ["newCard": card])
    }
    
    func removeCard(by id: UUID) {
        cards.removeValue(forKey: id)
        statuses.removeValue(forKey: id)
    }
}
