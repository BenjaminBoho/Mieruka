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
                TextField("", text: $task.task, onCommit: {
                    isEditing.toggle()
                })
                .textFieldStyle(.roundedBorder)
                .onAppear{
                    isEditing = true
                }
            } else {
                Text(task.task)
                    .font(.headline)
                    .onTapGesture{
                        isEditing.toggle()
                    }
            }
            
            Spacer()
        }
    }
}
//
//struct TaskRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRow(task: . .init(task: "123" ))
//    }
//}
