//
//  TaskViewController.swift
//  Mieruka
//
//  Created by れい on 2023/08/15.
//

import Foundation
import SwiftUI

struct TaskController {
    static func addNewTask(viewModel: TodoListManger, newTask: inout String) {
        viewModel.addTask(newTask)
        newTask = ""
    }
    
    static func taskRow(viewModel: TodoListManger, task: TodoTask, newTask: Binding<String>) -> some View {
        HStack {
            Button(action: {
                viewModel.toggleTaskCompleted(task)
            }) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
            }
            Text(task.task)
                .strikethrough(task.completed, color: .black)
                .foregroundColor(task.completed ? .gray : .primary)
            Spacer()
            Button(action: {
                newTask.wrappedValue = task.task
            }) {
                Image(systemName: "pencil")
            }
        }
    }


    static func taskInputRow(newTask: Binding<String>, viewModel: TodoListManger) -> some View {
        HStack {
            TextField("Add a task", text: newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                TaskController.addNewTask(viewModel: viewModel, newTask: &newTask.wrappedValue)
            }) {
                Image(systemName: "plus")
                    .font(.title)
            }
        }
    }
    
    static func editTask(viewModel: TodoListManger, task: TodoTask, newTask: inout String) {
        viewModel.editTask(task, newTask: newTask)
        newTask = ""
    }
}
