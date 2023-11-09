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
        
        POSTList(todoList: newTodoList) { result in
            switch result {
            case .success(let createdList):
                print("Successfully created list: \(createdList.name)")
            case .failure(let error):
                print("Failed to create list: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteList(_ list: TodoList) {
        if let index = todoLists.firstIndex(of: list) {
            todoLists.remove(at: index)
        }
    }
    
//    func fetchTodoTasks(for todoList: TodoList) {
//        let listIDToFetch = todoList.id
//        API().GETTasks(listId: listIDToFetch) { result in
//            switch result {
//            case .success(let tasks):
//                DispatchQueue.main.async {
//                    todoList.tasks = tasks
//                }
//            case .failure(let error):
//                print("Failed to fetch todo tasks: \(error.localizedDescription)")
//            }
//        }
//    }
}
