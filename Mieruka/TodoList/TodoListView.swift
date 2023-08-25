//
//  TodoListView.swift
//  Mieruka
//
//  Created by Kakeru Fukuda on 2023/08/25.
//

import SwiftUI

struct TodoListView: View {
    @StateObject var todoList: TodoList
    
    var body: some View {
        Section(header: Text(todoList.name), content: {
            ForEach($todoList.tasks.filter { !$0.wrappedValue.completed }) { task in
                TodoTaskView(task: task)
            }
            .onDelete {
                todoList.tasks.remove(atOffsets: $0)
            }

            ForEach($todoList.tasks.filter { $0.wrappedValue.completed }) { task in
                TodoTaskView(task: task)
            }
            .onDelete {
                todoList.tasks.remove(atOffsets: $0)
            }
        })
        TodoTaskInputView(viewModel: todoList)
    }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
