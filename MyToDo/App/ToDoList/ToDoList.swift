//
//  ToDoList.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct ToDoList: View {
    @State private var firstSelectedDataItem: TodoItem?
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    @State private var showLogOutAlert = false
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            VStack {
                List(todoViewModal.toDoListData?.todo ?? [],selection: $firstSelectedDataItem) { item in
                    ToDoViewItem(todo: item)
                        .onTapGesture {
                            let data = SelectedToDoScreenType(selectedToDo: item)
                            navStack.presentedScreen.append(data)
                            todoViewModal.selectedTodo = item
                        }
                    }
                .refreshable {
                    todoViewModal.getUserNotes()
                }
            }
            .onAppear {
                todoViewModal.getUserNotes()
            }
            .navigationTitle("Your ToDo")
            .alert(isPresented: $showLogOutAlert) {
                Alert(title: Text("Log out?"),
                      message: Text("Are you sure you want to logout out? Press 'OK' to confirm or 'Cancel' to stay Logged in."),
                      primaryButton: .destructive(Text("Yes")) {
                    authViewModel.userState = nil
                    authViewModel.token = ""
                    authViewModel.isLoggedIn = false
                    isSkipped = false
                    token = ""
                }, secondaryButton: .cancel())
            }
            .navigationBarItems(
                trailing:
                    VStack {
                        Button(action: {
//                            showLogOutAlert.toggle()
//                            print(todoViewModal.toDoListData.todo![0]!.body)
                        }) {
                            Text("Logout")
                        }
                    }
            )
            .navigationDestination(for: SelectedToDoScreenType.self) { type in
                SelectedToDo()
            }
            .navigationDestination(for: EditToDoScreenType.self) { type in
                EditToDo(todo: todoViewModal.selectedTodo!)
            }
        }
    }
}

//struct ToDoList_Previews: PreviewProvider {
//    static var previews: some View {
//            ToDoList()
//                .environmentObject(ToDoNavigationStackViewModal())
//                .environmentObject(ToDoViewModal())
//    }
//}
