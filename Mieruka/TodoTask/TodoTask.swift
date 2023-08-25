import Foundation

struct TodoTask: Identifiable {
    let id: UUID = UUID()
    var task: String
    var completed = false
}
