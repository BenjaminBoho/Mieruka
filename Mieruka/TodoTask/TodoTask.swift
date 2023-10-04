import Foundation

struct TodoTask: Identifiable {
    let id: UUID
    var task: String
    var completed = false
    var isEditing = false
}
