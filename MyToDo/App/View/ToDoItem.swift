//
//  ToDoItem.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct ToDoItem: View {
    var body: some View {
        VStack(alignment: .leading) {
                   Text("title")
                       .font(.title)
                       .foregroundColor(.accentColor)
                   Text("description")
                       .font(.body)
                       .foregroundColor(.secondary)
               }
    }
}

struct ToDoItem_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItem()
    }
}
