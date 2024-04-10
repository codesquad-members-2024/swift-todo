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
    let title: String
    let description: String
    let platform: String
    let status: CardStatus
}
