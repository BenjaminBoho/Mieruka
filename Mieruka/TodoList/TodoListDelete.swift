//
//  TodoListDelete.swift
//  Mieruka
//
//  Created by れい on 2023/08/30.
//

import SwiftUI

struct TodoListDelete: View {
    var onDelete: () -> Void
    
    var body: some View {
        Button(action: {
            onDelete()
        }) {
            Text("Delete List")
                .foregroundColor(.red)
        }
    }
}
