//
//  ToDoList.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct ToDoList: View {
    
    @State private var firstSelectedDataItem: TodoItem?
    
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            VStack {
                if(todoViewModal.todoListErrorMessage != nil) {
                    ErrorMessageView(errorMessage: todoViewModal.todoListErrorMessage, clicked: getUserTodo)
                } else {
                    List(todoViewModal.toDoListData?.todo ?? [],id: \.self,selection: $firstSelectedDataItem) { item in
                        ToDoViewItem(todo: item)
                            .onTapGesture {
                                let data = SelectedToDoScreenType(selectedToDo: item)
                                navStack.presentedScreen.append(data)
                                todoViewModal.selectedTodo = item
                            }
                    }
                    
                }
            }
            .refreshable {
                getUserTodo()
            }
            .navigationTitle("Home")
            .navigationDestination(for: SelectedToDoScreenType.self) { type in
                SelectedToDo()
            }
            .navigationDestination(for: EditToDoScreenType.self) { type in
                EditToDo(todo: todoViewModal.selectedTodo!)
            }
        }
    }
    
    func getUserTodo() {
        todoViewModal.getUserNotes {_,_ in
          
        }
    }
    
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ToDoList()
                .environmentObject(ToDoNavigationStackViewModal())
                .environmentObject(ToDoViewModal())
        }
    }
}
