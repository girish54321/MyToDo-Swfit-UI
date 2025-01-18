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
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(todo.title ?? "NA")
                        .font(.title)
                        .foregroundColor(.accentColor)
                    Text(todo.body ?? "NA")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top,2)
    }
}

struct ToDoViewItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ForEach(1...5,id:\.self) { item in
                    ToDoViewItem(
                        todo: TodoItem(
                            id: "1",
                            title: "Your Text",
                            body: "Body",
                            state: "",
                            userID: "1",
                            createdAt: "",
                            updatedAt: "",
                            files: nil)
                    )
                }
            }
            .navigationTitle("Todo List")
        }
       
    }
}
