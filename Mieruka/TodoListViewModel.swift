//
//  TodoListViewModel.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todoItems: [TodoItem] = []

    func addTask(_ task: String) {
        todoItems.append(TodoItem(task: task))
    }

    func toggleTaskCompleted(_ item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].completed.toggle()
        }
    }
}
