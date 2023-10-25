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
    
    func add(task: String) {
        //tasks += [TodoTask(id: String(), task: task)]
        let newTask = TodoTask(id: UUID().uuidString, tasks: String(), completed: false)
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
    
    func fetchTodoTasks() {
            API().GETTasks { result in
                switch result {
                case .success(let tasks):
                    DispatchQueue.main.async {
                        self.tasks = tasks
                    }
                case .failure(let error):
                    print("Failed to fetch todo tasks: \(error.localizedDescription)")
                }
            }
        }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
