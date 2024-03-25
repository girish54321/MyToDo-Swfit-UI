//
//  ToDoItem.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct ToDoViewItem: View {
    var todo: TodoItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(todo.title ?? "NA")
                       .font(.title)
                       .foregroundColor(.accentColor)
            Text(todo.body ?? "NA")
                       .font(.body)
                       .foregroundColor(.secondary)
               }
    }
}

struct ToDoViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ToDoViewItem(todo: TodoItem(id: 1, title: "", body: "", status: "", todoImage: "", userID: 1, createdAt: "", updatedAt: ""))
    }
}
