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
            fetchTodoList { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let todoLists):
                        TodoListManager.shared.todoLists = todoLists
                    case .failure(let error):
                        print("Failed to fetch todo lists: \(error.localizedDescription)")
                    }
                }
            }

        case .failure(let error):
            print("Failed to delete todo list: \(error.localizedDescription)")
        }
        fetchTodoList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todoLists):
                    TodoListManager.shared.todoLists = todoLists
                case .failure(let error):
                    print("Failed to fetch todo lists: \(error.localizedDescription)")
                }
            }
        }
    }
}

internal func fetchTodoList(completion: @escaping (Result<[TodoList], Error>) -> Void) {
    API().GET { result in
        switch result {
        case .success(let todoListHeaders):
            let todoLists = todoListHeaders.map { TodoList(header: $0) }
            completion(.success(todoLists))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

internal func fetchTodoTasks(forList listId: String, completion: @escaping (Result<[TodoTask], Error>) -> Void) {
    API().GETTasks(listId: listId) { result in
        switch result {
        case .success(let tasks):
            completion(.success(tasks))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}




internal func POSTTask(task: TodoTask, completion: @escaping (Result<TodoTaskHeader, Error>) -> Void) {
    API().POSTTodoTask(todoTask: task) { result in
        switch result {
        case .success(let taskHeader):
            completion(.success(taskHeader))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}



internal func POSTList(todoList: TodoList, completion: @escaping (Result<TodoListHeader, Error>) -> Void) {

    API().POST(todoList: todoList) { (result: Result<TodoListHeader, Error>) in
        switch result {
        case .success(let listHeader):
            completion(.success(listHeader))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

internal func updateTaskCompletion(task: TodoTask, completed: Bool, completion: @escaping () -> Void) {
    API().updateTaskCompleted(taskID: task.id, completed: completed) { (result: Result<Data, Error>) in
        switch result {
        case .success:
            print("Task completion status updated successfully.")
            completion()
        case .failure(let error):
            print("Failed to update task completion status: \(error.localizedDescription)")
        }
    }
}
