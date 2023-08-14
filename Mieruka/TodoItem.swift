//
//  TodoListView.swift
//  Mieruka
//
//  Created by れい on 2023/08/14.
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    var task: String
    var completed: Bool = false
}
