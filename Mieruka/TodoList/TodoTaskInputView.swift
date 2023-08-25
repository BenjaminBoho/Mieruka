//
//  TodoTaskInputView.swift
//  Mieruka
//
//  Created by Kakeru Fukuda on 2023/08/25.
//

import SwiftUI

struct TodoTaskInputView: View {
    @StateObject var viewModel: TodoList
    @State var newTask: String = ""
    
    var body: some View {
        HStack {
            TextField("Add a task", text: $newTask)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                
                #if DEBUG
                if newTask.isEmpty {
                    newTask = String(UUID().uuidString.suffix(8))
                }
                #endif
                
                viewModel.add(task: newTask)
                newTask = ""
            }) {
                Image(systemName: "plus")
                    .font(.title)
            }
        }
    }
}

