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
        HStack {
            Spacer()
            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash.fill")
                    .foregroundColor(Color(red: 40 / 255.0, green: 40 / 255.0, blue: 40 / 255.0))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
