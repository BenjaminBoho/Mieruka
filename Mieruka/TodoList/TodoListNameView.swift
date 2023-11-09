//
//  TodoListNameView.swift
//  Mieruka
//
//  Created by れい on 2023/08/30.
//

import SwiftUI

struct TodoListNameView: View {
    @StateObject var todoList: TodoList
    @State private var listIsEditing = false
    
    var body: some View {
        if listIsEditing {
            TextField("", text: $todoList.name, onCommit: {
                listIsEditing.toggle()
                todoList.updateListName { result in
                }
            })
            .textFieldStyle(.roundedBorder)
            .onTapGesture {
                listIsEditing = true
            }
            .frame(minHeight: 30)
        } else {
            Text(todoList.name)
                .font(.headline)
            .onTapGesture{
                listIsEditing.toggle()
            }
            TodoListDelete {
                deleteTodoList(todoList){
                }
            }
        }
    }
}
