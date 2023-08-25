//
//  TaskController.swift
//  Mieruka
//
//  Created by れい on 2023/08/15.
//

import Foundation
import SwiftUI

struct TaskController {
    static func addNewTask(viewModel: TodoListManager, newTask: inout String, listIndex: Int) {
            viewModel.addTask(newTask, toListAtIndex: listIndex)
            newTask = ""
        }

    static func taskInputRow(newTask: Binding<String>, viewModel: TodoListManager, listIndex: Int) -> some View {
        HStack {
            TextField("Add a task", text: newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                TaskController.addNewTask(viewModel: viewModel, newTask: &newTask.wrappedValue, listIndex: listIndex)
            }) {
                Image(systemName: "plus")
                    .font(.title)
            }
        }
    }
}
