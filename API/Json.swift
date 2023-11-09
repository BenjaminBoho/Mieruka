//
//  Json.swift
//  Mieruka
//
//  Created by れい on 2023/10/04.
//

import Foundation

extension TodoList {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "listId"
        case name
    }
}

extension TodoTask {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(tasks, forKey: .tasks)
        try container.encode(completed, forKey: .completed)
        try container.encode(listId, forKey: .listId)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "taskId"
        case tasks
        case completed
        case listId
    }
}
