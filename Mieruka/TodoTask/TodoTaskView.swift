//
//  TaskRow.swift
//  Mieruka
//
//  Created by れい on 2023/08/22.
//

import SwiftUI

struct TodoTaskView: View {
    @Binding var task: TodoTask
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    task.completed.toggle()
                }
            }) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
            }
            
            if isEditing {
                TextField("", text: $task.tasks, onCommit: {
                    isEditing.toggle()
                    API().updateTask(task: task) { result in
                        switch result {
                        case .success:
                            print("Task updated successfully.")
                        case .failure(let error):
                            print("Failed to update task: \(error.localizedDescription)")
                        }
                    }
                })
                .textFieldStyle(.roundedBorder)
                .onAppear{
                    isEditing = true
                }
            } else {
                Text(task.tasks)
                    .font(.headline)
                    .onTapGesture{
                        isEditing.toggle()
                    }
            }
        }
    }
}
//
//struct TaskRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRow(task: . .init(task: "123" ))
//    }
//}
