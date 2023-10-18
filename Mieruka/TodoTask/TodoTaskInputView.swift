import SwiftUI

struct TodoTaskInputView: View {
    @StateObject var viewModel: TodoList
    @State var newTask: String = ""
    
    var body: some View {
        HStack {
            TextField("Add a task", text: $newTask)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                viewModel.add(task: newTask)
                newTask = ""
            }) {
                Image(systemName: "plus")
                    .font(.title)
            }
        }
    }
}

