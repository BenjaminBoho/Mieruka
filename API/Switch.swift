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
    
