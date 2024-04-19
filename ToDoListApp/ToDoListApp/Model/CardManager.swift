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
    func containsCard(with id: UUID) -> Bool
    func moveCard(from oldIndex: Int, to newIndex: Int, within status: CardStatus)
    func index(of card: ToDoCard, in status: CardStatus) -> Int?
    func card(for status: CardStatus, with id: UUID) -> ToDoCard?
    func updateCard(_ updatedCard: ToDoCard)
}

class CardManager: CardManaging {
    enum Notifications {
        static let NewCardAdded = Notification.Name("NewCardAdded")
        static let CardMoved = Notification.Name("CardMoved")
        static let CardDeleted = Notification.Name("CardDeleted")
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
    
    func index(of card: ToDoCard, in status: CardStatus) -> Int? {
        let sortedCards = cards(for: status)
        return sortedCards.firstIndex { $0.id == card.id }
    }
    
    func count(for status: CardStatus) -> Int {
        return cards(for: status).count
    }
    
    func cards(for status: CardStatus) -> [ToDoCard] {
        return statuses.filter { $0.value == status }.compactMap { cards[$0.key] }
    }
    
    func card(for status: CardStatus, with id: UUID) -> ToDoCard? {
        guard let cardStatus = statuses[id], cardStatus == status else { return nil }
        return cards[id]
    }
    
    func card(for status: CardStatus, at index: Int) -> ToDoCard? {
        let filteredCards = cards(for: status)
        guard index >= 0 && index < filteredCards.count else { return nil }
        return filteredCards[index]
    }
    
    func addCard(_ card: ToDoCard, with status: CardStatus) {
        cards[card.id] = card
        statuses[card.id] = status
        logger.log(level: .info, "[ 생성된 카드 ]: \(String(describing: card.description)).\n[ 카드 Status ]: \(String(describing: self.statuses[card.id])) \n[ 총 cards 갯수 ]: \(self.cards.count)")
        NotificationCenter.default.post(name: Self.Notifications.NewCardAdded, object: nil, userInfo: ["newCard": card])
    }
    
    func moveCard(from oldIndex: Int, to newIndex: Int, within status: CardStatus) {
        let cardsInStatus = cards.filter { statuses[$0.key] == status }.sorted(by: { $0.key.uuidString < $1.key.uuidString })
        
        guard oldIndex < cardsInStatus.count, newIndex < cardsInStatus.count else { return }
        
        let cardToMove = cardsInStatus[oldIndex].value
        let cardId = cardsInStatus[oldIndex].key
        
        cards.removeValue(forKey: cardId)
        
        var reorderedCards = cardsInStatus.map { $0.value }
        reorderedCards.remove(at: oldIndex)
        reorderedCards.insert(cardToMove, at: newIndex)
        
        cards[cardId] = cardToMove
        
        NotificationCenter.default.post(name: Self.Notifications.CardMoved, object: nil, userInfo: ["cardId": cardId])
    }
    
    func containsCard(with id: UUID) -> Bool {
        return cards.keys.contains(id)
    }
    
    func removeCard(by id: UUID) {
        logger.log(level: .info, "[ 삭제되는 카드 ]: \(String(describing: self.cards[id])).\n[ 삭제되는 카드 Status ]: \(String(describing: self.statuses[id])) \n[ 총 cards 갯수 ]: \(self.cards.count - 1)")
        cards.removeValue(forKey: id)
        statuses.removeValue(forKey: id)
        NotificationCenter.default.post(name: Self.Notifications.CardDeleted, object: nil)
    }
    
    func updateCard(_ updatedCard: ToDoCard) {
        cards[updatedCard.id] = updatedCard
    }
}
