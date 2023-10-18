//
//  TodoList.swift
//  Mieruka
//
//  Created by れい on 2023/08/30.
//

import Foundation

struct TodoListHeader: Codable {
    let id: String
    let name: String
}

class TodoList: Identifiable, Equatable, ObservableObject {
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
    
    init(header: TodoListHeader) {
        self.id = header.id
        self.name = header.name
    }
    
    static func == (lhs: TodoList, rhs: TodoList) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    var name: String
    
    @Published var tasks: [TodoTask] = []
    
    func add(task: String) {
        tasks += [TodoTask(id: UUID(), task: task)]
    }
}
