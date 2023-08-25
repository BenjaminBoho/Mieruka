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
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            contentView
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Todo List")
                            .foregroundColor(.white)
                            .toolbarColorScheme(.dark)
                            .font(.system(size: 30, weight: .bold, design: .monospaced))
                    }
                }
                .background(Color(red: 40 / 255.0, green: 40 / 255.0, blue: 40 / 255.0))
        }
    }
    
    private var contentView: some View {
        VStack {
            List {
                ForEach(viewModel.todoLists) { list in
                    Section(header: Text(list.name), content: {
                        ForEach(list.tasks) { task in
                            TaskRow(task: task)
                                .onTapGesture {
                                    viewModel.todoLists[viewModel.todoLists.firstIndex(of: list)!].toggleTaskCompleted(task)
                                }
                        }
                        .onDelete(perform: list.removeTasks)
                    })
                    TaskController.taskInputRow(newTask: $newTask, viewModel: viewModel, listIndex: viewModel.todoLists.firstIndex(of: list)!)
                }
            }
            .cornerRadius(10)
            ListController.addListButton(newListName: $newListName, viewModel: viewModel)
        }
        .padding()
    }
}
