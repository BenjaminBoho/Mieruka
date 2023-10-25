//
//  Json.swift
//  Mieruka
//
//  Created by れい on 2023/10/04.
//

import Foundation

func decodeJSON() throws -> TodoList {
    let json = """
    {
        "id": 1,
        "name": ""
    }
    """.data(using: .utf8)!

    let decoder = JSONDecoder()
    let item = try decoder.decode(TodoListHeader.self, from: json)
    return TodoList(header: item)
}

func encodeJSON(todoList: TodoList) throws -> Data {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    let jsonData = try encoder.encode(todoList)
    
    return jsonData
}

func decodeJSON(data: Data) throws -> TodoTask {
    let json = """
    {
        "id": 1,
        "name": "",
        "List_Id: "",
    }
    """.data(using: .utf8)!
    let decoder = JSONDecoder()

    _ = try decoder.decode(TodoTask.self, from: json)
        return TodoTask(id: String(), tasks: String())
}
