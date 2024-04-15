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
    
    init(title: String, description: String, platform: String) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.platform = platform
    }
}
