import Foundation

struct TodoTask: Identifiable, Codable {
    let id: UUID
    var task: String
    var completed = false
    var isEditing = false

    enum CodingKeys: String, CodingKey {
        case id
        case task
        case completed
        case isEditing
    }

    init(id: UUID, task: String, completed: Bool = false, isEditing: Bool = false) {
        self.id = id
        self.task = task
        self.completed = completed
        self.isEditing = isEditing
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        task = try container.decode(String.self, forKey: .task)
        completed = try container.decode(Bool.self, forKey: .completed)
        isEditing = try container.decode(Bool.self, forKey: .isEditing)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(task, forKey: .task)
        try container.encode(completed, forKey: .completed)
        try container.encode(isEditing, forKey: .isEditing)
    }
}
