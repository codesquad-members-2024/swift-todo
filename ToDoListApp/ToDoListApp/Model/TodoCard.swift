//
//  TodoCard.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/9/24.
//

import Foundation

enum CardStatus {
    case toDO
    case inProgress
    case done
}

struct ToDoCard {
    let id: UUID
    let title: String
    let description: String
    let platform: String
    let status: CardStatus
    
    init(title: String, description: String, platform: String, status: CardStatus) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.platform = platform
        self.status = status
    }
}
