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

func decodeJSON() throws -> TodoTaskHeader {
    let json = """
    {
        "id": 1,
        "tasks": "",
        "complete: false
    }
    """.data(using: .utf8)!
    let decoder = JSONDecoder()
    let task = try decoder.decode(TodoTaskHeader.self, from: json)
    return task
}
