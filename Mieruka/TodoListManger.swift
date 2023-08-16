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
            reorderTasks()
        }
    }
    
    func removeTasks(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
    
    func reorderTasks() {
        let completedTasks = todoItems.filter{ $0.completed }
        let uncompletedTasks = todoItems.filter{ !$0.completed }
        todoItems = uncompletedTasks + completedTasks
    }
    
    func editTask(_ item: TodoTask, newTask: String) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].task = newTask
        }
    }
}

struct TodoTask: Identifiable {
    let id: UUID
    var task: String
    var completed = false
}
