import Foundation

internal struct TodoTask: Identifiable {
    let id: String
    var tasks: String
    var completed = false
    var isEditing = false
    let listId: String
}
