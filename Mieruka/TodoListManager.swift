//
//  TodoListManager.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation

class TodoListManager: ObservableObject {
    static let shared = TodoListManager()
    @Published var todoLists: [TodoList] = []
    @Published var todoTasks: [TodoTask] = []
    
    func addList(named name: String) {
            let newTodoList = TodoList(name: name)
            todoLists.append(newTodoList)
            
            API().POST(todoList: newTodoList) { result in
                switch result {
                case .success:
                    print("List added successfully.")
                case .failure(let error):
                    print("Failed to add list: \(error.localizedDescription)")
                }
            }
        }
    
    func deleteList(at index: Int) {
        todoLists.remove(at: index)
    }
    
    func fetchTodoList() {
        API().GET { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.todoLists = items
                }
            case .failure(let error):
                print("Failed to fetch todo items: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTodoTasks() {
        API().GETTasks { result in
            switch result {
            case .success(let tasks):
                DispatchQueue.main.async {
                    self.todoTasks = tasks
                }
            case .failure(let error):
                print("Failed to fetch todo tasks: \(error.localizedDescription)")
            }
        }
    }
}
