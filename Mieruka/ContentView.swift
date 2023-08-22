//
//  File.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var viewModel = TodoListManager()
    @State private var newTask = ""
    @State private var editedTask = ""
    @State private var newListName = ""
    
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
                ForEach(viewModel.todoLists) { list in
                    Section(header: Text(list.name), content: {
                        ForEach(list.tasks.sorted(by: {$0.completed || $1.completed } )) { task in
                            TaskRow(task: task)
                        }
                        TaskController.taskInputRow(newTask: $newTask, viewModel: viewModel, listIndex: viewModel.todoLists.firstIndex(of: list)!)
                    })
                }
//                .onDelete(perform: viewModel.removeTasks)
            }
            ListController.addListButton(newListName: $newListName, viewModel: viewModel)
        }
    }
}
