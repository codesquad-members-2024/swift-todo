//
//  CardManager.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/11/24.
//

import Foundation
import os

class CardManager {
    private var cards: [ToDoCard]
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "CardManager")
    private let notificationCenter: NotificationCenter

    init(cards: [ToDoCard] = [], notificationCenter: NotificationCenter = .default) {
        self.cards = cards
        self.notificationCenter = notificationCenter
    }
    
    var count: Int {
        return self.cards.count
    }
    
    func cards(for status: CardStatus) -> [ToDoCard] {
        return cards.filter { $0.status == status}
    }
    
    func findCard(by id: UUID) -> ToDoCard? {
        return cards.first { $0.id == id }
    }
    
    func addCard(_ card: ToDoCard) {
        logger.log(level: .info, "[ 생성된 카드 ]: \(String(describing: card)). \n[ 총 cards 갯수 ]: \(self.cards.count + 1)")
        self.cards.append(card)
        notificationCenter.post(name: .NewCardAdded, object: nil, userInfo: ["newCard": card])
    }
    
    func removeCard(by id: UUID) {
        if let index = cards.firstIndex(where: { $0.id == id }) {
            cards.remove(at: index)
        }
    }
}
