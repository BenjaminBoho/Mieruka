//
//  TodoListManager.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation

class TodoListManager: ObservableObject {
    
    private init() {} 
    static let shared = TodoListManager()
    @Published var todoLists: [TodoList] = []
    
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
    
    func deleteList(_ list: TodoList) {
        if let index = todoLists.firstIndex(of: list) {
            todoLists.remove(at: index)
        }
    }
    
    func fetchTodoList() {
        API().GET { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.todoLists = items
                }
                print("Fetch list successfully")
            case .failure(let error):
                print("Failed to fetch todo items: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTodoTasks(for todoList: TodoList) {
        let listIDToFetch = todoList.id
        API().GETTasks(listId: listIDToFetch) { result in
            switch result {
            case .success(let tasks):
                DispatchQueue.main.async {
                    todoList.tasks = tasks
                }
            case .failure(let error):
                print("Failed to fetch todo tasks: \(error.localizedDescription)")
            }
        }
    }
}
