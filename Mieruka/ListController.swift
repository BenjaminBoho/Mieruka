//
//  ListController.swift
//  Mieruka
//
//  Created by れい on 2023/08/21.
//

import Foundation
import SwiftUI

struct ListController {
    static func addListButton(newListName: Binding<String>, viewModel: TodoListManager) -> some View {
        HStack {
            TextField("New list name", text: newListName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                ListController.addNewList(viewModel: viewModel, newListName: &newListName.wrappedValue)
            }) {
                Text("Add List")
                    .foregroundColor(Color.white)
            }
        }
    }
    
    static func addNewList(viewModel: TodoListManager, newListName: inout String) {
        viewModel.addList(named: newListName)
        newListName = ""
    }
    
    static func deleteFiles(viewModel: TodoListManager, at offsets: IndexSet) {
        viewModel.todoLists.remove(atOffsets: offsets)
    }
    
    static func addTaskButton(newTask: Binding<String>, viewModel: TodoListManager, listIndex: Int?) -> some View {
        HStack {
            TextField("New task", text: newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                ListController.addNewTask(viewModel: viewModel, newTask: &newTask.wrappedValue, listIndex: listIndex)
            }) {
                Text("Add Task")
            }
        }
    }

    static func addNewTask(viewModel: TodoListManager, newTask: inout String, listIndex: Int?) {
        guard let index = listIndex else {
            return
        }
        viewModel.addTask(newTask, toListAtIndex: index)
        newTask = ""
    }
}
