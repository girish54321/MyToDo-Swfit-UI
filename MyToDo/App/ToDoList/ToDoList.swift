//
//  ToDoList.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct ToDoList: View {
    
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            List {
                Button (action: {
                    let data = SelectedToDoScreenType(selectedToDo: nil)
                    navStack.presentedScreen.append(data)
                }, label: {
                    ToDoItem()
                })
//                .buttonStyle(.plain)
                
                   
                ToDoItem()
                ToDoItem()
                ToDoItem()
                ToDoItem()
            }
//            .listStyle(PlainListStyle())
//            .navigationDestination(for: SelectedArticleScreenType.self) { type in
//                ArticleDetailViewScreen(activeStack:.feed)
//            }
            .navigationDestination(for: SelectedToDoScreenType.self) { type in
                ToDoList()
            }
            .navigationBarTitle("Let's Do This!")
        }
    }
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList()
            .environmentObject(ToDoNavigationStackViewModal())
    }
}
