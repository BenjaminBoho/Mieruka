//
//  TodoListViewModel.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation

class TodoListManager: ObservableObject {
    @Published var todoLists: [TodoList] = []

    func addTask(_ task: String, toListAtIndex index: Int) {
        let newTask = TodoTask(task: task)
        todoLists[index].tasks.append(newTask)
    }

    func addList(named name: String) {
        todoLists.append(TodoList(name: name))
    }
}

class TodoTask: Identifiable, ObservableObject {
    init(task: String) {
        self.task = task
    }
    let id: UUID = UUID()
    @Published var task: String
    @Published var completed = false
}

class TodoList: Identifiable,Equatable ,ObservableObject {
    init(name: String) {
        self.name = name
    }
    static func == (lhs: TodoList, rhs: TodoList) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var name: String = ""
    @Published var tasks: [TodoTask] = []
    
    func toggleTaskCompleted(_ item: TodoTask) {
        if let index = tasks.firstIndex(where: { $0.id == item.id }) {
            tasks[index].completed.toggle()
//            reorderTasks()
        }
    }
    
    func removeTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func editTask(_ item: TodoTask, newTask: String) {
        if let index = tasks.firstIndex(where: { $0.id == item.id }) {
            tasks[index].task = newTask
        }
    }
}
