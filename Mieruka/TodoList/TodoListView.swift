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
                    deleteTask(task: task)
                }
                todoList.tasks.remove(atOffsets: indices)
            }
            
            ForEach($todoList.tasks.filter { $0.wrappedValue.completed }) { task in
                TodoTaskView(task: task)
            }
            .onDelete { indices in
                for index in indices {
                    let task = todoList.tasks[index]
                    deleteTask(task: task)
                }
                todoList.tasks.remove(atOffsets: indices)
            }
            TodoTaskInputView(viewModel: todoList)
        })
        .onAppear {
            fetchTodoTasks(forList: todoList.id) { result in
                switch result {
                case .success(let tasks):
                    DispatchQueue.main.async {
                        todoList.tasks = tasks
                    }
                case .failure(let error):
                    print("Error fetching tasks: \(error)")
                }
            }
        }
    }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
