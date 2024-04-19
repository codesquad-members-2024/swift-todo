//
//  TodoCard.swift
//  ToDoListApp
//
//  Created by 조호근 on 4/9/24.
//

import Foundation
import MobileCoreServices

enum CardStatus {
    case toDO
    case inProgress
    case done
}

class ToDoCard: NSObject, Codable {
    let id: UUID
    var title: String
    var descriptionText: String
    let platform: String
    
    init(title: String, descriptionText: String, platform: String) {
        self.id = UUID()
        self.title = title
        self.descriptionText = descriptionText
        self.platform = platform
    }
    
    override var description: String {
        return "ToDoCard(id: \(id), title: \(title), description: \(descriptionText), platform: \(platform))"
    }
}

extension ToDoCard: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData as String)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping @Sendable (Data?, (any Error)?) -> Void) -> Progress? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return nil
    }
}

extension ToDoCard: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData as String)]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        let decoder = JSONDecoder()
        let obj = try decoder.decode(self, from: data)
        return obj
    }
}
