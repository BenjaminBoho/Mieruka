//
//  File.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TodoListViewModel()
    @State private var newTask = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.todoItems) { item in
                        HStack {
                            Button(action: {
                                viewModel.toggleTaskCompleted(item)
                            }) {
                                Image(systemName: item.completed ? "checkmark.circle.fill" : "circle")
                            }
                            Text(item.task)
                                .strikethrough(item.completed, color: .black)
                                .foregroundColor(item.completed ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                
                HStack {
                    TextField("Add a task...", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewModel.addTask(newTask)
                        newTask = ""
                    }) {
                        Text("Add")
                    }
                }
                .padding()
            }
            .padding()
            .navigationTitle("Todo List")
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        viewModel.todoItems.remove(atOffsets: offsets)
    }
}
