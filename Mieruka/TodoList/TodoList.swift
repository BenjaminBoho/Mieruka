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

class TodoList: Identifiable, Equatable, ObservableObject, Encodable {
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
    
    //tasks += [TodoTask(id: String(), task: task)]
    func add(task: String) {
        let newTask = TodoTask(id: UUID().uuidString, tasks: task, completed: false)
        tasks.append(newTask)
        
        let taskHeader = TodoTaskHeader(id: newTask.id, tasks: newTask.tasks, completed: newTask.completed)
        
        API().POSTTodoTask(todoTask: taskHeader) { result in
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
