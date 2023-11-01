//
//  Header.swift
//  Mieruka
//
//  Created by れい on 2023/10/25.
//

import Foundation

internal struct TodoTaskHeader: Codable {
    let taskId: String
    let tasks: String
    let completed : Bool
    let listId: String
}
