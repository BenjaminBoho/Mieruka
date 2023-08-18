//
//  File.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TodoListManger()
    @State private var newTask = ""
    @State private var editedTask = ""
    
    var body: some View {
        NavigationView {
            contentView
                .padding()
                .navigationTitle("Todo List")
        }
    }
    
    private var contentView: some View {
        VStack {
            List {
                ForEach(viewModel.todoItems) { task in
                    TaskController.taskRow(viewModel: viewModel, task: task, newTask: $newTask)
                }
                .onDelete(perform: viewModel.removeTasks)
            }
            TaskController.taskInputRow(newTask: $newTask, viewModel: viewModel)
        }
    }
}
