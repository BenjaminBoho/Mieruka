//
//  TodoListView.swift
//  Mieruka
//
//  Created by Kakeru Fukuda on 2023/08/25.
//

import SwiftUI

struct TodoListView: View {
    @StateObject var todoList: TodoList
    @State private var listIsEditing = false
    @State private var todoItemsData: Data?
    
    var body: some View {
        Section(header: TodoListNameView(todoList: todoList), content: {
            ForEach($todoList.tasks.filter { !$0.wrappedValue.completed }) { task in
                TodoTaskView(task: task)
            }
            .onDelete { indices in
                for index in indices {
                    let task = todoList.tasks[index]
                    let taskIDToDelete = task.id
                    API().deleteTask(taskID: taskIDToDelete) { result in
                        switch result {
                        case .success:
                            print("Task deleted successfully.")
                        case .failure(let error):
                            print("Failed to delete task: \(error.localizedDescription)")
                        }
                    }
                    todoList.tasks.remove(atOffsets: indices)
                }
            }
            
            ForEach($todoList.tasks.filter { $0.wrappedValue.completed }) { task in
                TodoTaskView(task: task)
            }
            .onDelete {
                todoList.tasks.remove(atOffsets: $0)
            }
            TodoTaskInputView(viewModel: todoList)
        })
        .onAppear {
            TodoListManager.shared.fetchTodoTasks(for: todoList)
        }
    }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
