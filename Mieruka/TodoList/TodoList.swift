//
//  TodoList.swift
//  Mieruka
//
//  Created by れい on 2023/08/30.
//

import Foundation

class TodoList: Identifiable ,Equatable ,ObservableObject {
    init(name: String) {
        self.name = name
    }
    static func == (lhs: TodoList, rhs: TodoList) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String = ""
    
    @Published var tasks: [TodoTask] = []
    
    func add(task: String) {
        tasks += [TodoTask(id: UUID(), task: task)]
    }
}
