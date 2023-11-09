//
//  TodoList.swift
//  Mieruka
//
//  Created by れい on 2023/08/30.
//

import Foundation

struct TodoListHeader: Codable {
    let listId: String
    let name: String
}

class TodoList: Identifiable, Equatable, ObservableObject, Encodable {
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
    
    init(header: TodoListHeader) {
        self.id = header.listId
        self.name = header.name
    }
    
    static func == (lhs: TodoList, rhs: TodoList) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    var name: String
    
    @Published var tasks: [TodoTask] = []
    
    //tasks += [TodoTask(id: String(), task: task)]
    func add(task: String) {
        let newTask = TodoTask(id: UUID().uuidString, tasks: task, completed: false, listId: self.id)
        tasks.append(newTask)
        
        POSTTask(task: newTask) { result in
            switch result {
            case .success:
                print("Task added successfully.")
            case .failure(let error):
                print("Failed to add task: \(error.localizedDescription)")
            }
        }
    }
    
    func updateListName(completion: @escaping (Result<Void, Error>) -> Void) {
        API().updateListName(list: self) { result in
            switch result {
            case .success:
                print("List name updated successfully.")
            case .failure(let error):
                print("Failed to update list name: \(error.localizedDescription)")
            }
            completion(result)
        }
    }
}
