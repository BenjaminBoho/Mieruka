//
//  TodoListManager.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation

class TodoListManager: ObservableObject {
    @Published var todoLists: [TodoList] = []

    func addList(named name: String) {
        todoLists.append(TodoList(name: name))
    }
}
