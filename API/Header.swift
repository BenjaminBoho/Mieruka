//
//  Header.swift
//  Mieruka
//
//  Created by れい on 2023/10/25.
//

import Foundation

internal struct TodoTaskHeader: Codable {
    let id: String
    let tasks: String
    let completed : Bool
}
