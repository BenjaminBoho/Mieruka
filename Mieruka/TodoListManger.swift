//
//  TodoListViewModel.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation

class TodoListManger: ObservableObject {
    @Published var todoItems: [TodoTask] = []

    func addTask(_ task: String) {
        todoItems.append(TodoTask(id: UUID(), task: task))
    }

    func toggleTaskCompleted(_ item: TodoTask) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].completed.toggle()
        }
    }
    
    func removeTasks(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
}

struct TodoTask: Identifiable {
    let id: UUID
    var task: String
    var completed = false
}
