//
//  ListController.swift
//  Mieruka
//
//  Created by れい on 2023/08/21.
//

import Foundation
import SwiftUI

struct ListController {
    static func addListButton(newListName: Binding<String>, viewModel: TodoListManager) -> some View {
        HStack {
            TextField("New list name", text: newListName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                ListController.addNewList(viewModel: viewModel, newListName: &newListName.wrappedValue)
            }) {
                Image(systemName: "plus")
                    .foregroundColor(Color.white)
                    .padding()
            }
        }
    }
    
    static func addNewList(viewModel: TodoListManager, newListName: inout String) {
        viewModel.addList(named: newListName)
        newListName = ""
    }
}
