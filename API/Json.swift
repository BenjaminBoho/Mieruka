//
//  Json.swift
//  Mieruka
//
//  Created by れい on 2023/10/04.
//

import Foundation

struct ListItem: Codable {
    var id: Int
    var name: String
}

func decodeJSON() throws -> ListItem {
    let json = """
    {
        "id": 1,
        "name": ""
    }
    """.data(using: .utf8)!

    let decoder = JSONDecoder()
    let item = try decoder.decode(ListItem.self, from: json)
    return item
}

