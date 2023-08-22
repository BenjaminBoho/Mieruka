//
//  TaskRow.swift
//  Mieruka
//
//  Created by れい on 2023/08/22.
//

import SwiftUI

struct TaskRow: View {
    @StateObject var task: TodoTask
    
    var body: some View {
        HStack {
            Button(action: {
                task.completed.toggle()
            }) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
            }
                TextField("", text: $task.task)
                    .textFieldStyle(.roundedBorder)
            Spacer()
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: .init(task: "123" ))
    }
}
