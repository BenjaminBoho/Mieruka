//
//  Switch.swift
//  Mieruka
//
//  Created by れい on 2023/11/01.
//

import Foundation

internal func deleteTask(task: TodoTask) {
    let taskIDToDelete = task.id
    API().deleteTask(taskID: taskIDToDelete) { result in
        switch result {
        case .success:
            print("Task deleted successfully.")
        case .failure(let error):
            print("Failed to delete task: \(error.localizedDescription)")
        }
    }
}

internal func updateTask(task: TodoTask) {
    API().updateTask(task: task) { result in
        switch result {
        case .success:
            print("Task updated successfully.")
        case .failure(let error):
            print("Failed to update task: \(error.localizedDescription)")
        }
    }
}

internal func deleteTodoList(_ list: TodoList, completion: @escaping () -> Void) {
    let listIDToDelete = list.id
    API().deleteList(listID: listIDToDelete) { result in
        switch result {
        case .success:
            print("Todo list deleted successfully.")
            TodoListManager.shared.fetchTodoList()
        case .failure(let error):
            print("Failed to delete todo list: \(error.localizedDescription)")
            TodoListManager.shared.fetchTodoList()
        }
    }
}
