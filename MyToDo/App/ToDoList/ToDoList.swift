//
//  ToDoList.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct ToDoList: View {
    
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal
    @State private var firstSelectedDataItem: TodoItem?
    @State private var toDoList: ToDo?
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    @State private var showLogOutAlert = false
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            VStack {
                List(toDoList?.todo ?? [],selection: $firstSelectedDataItem) { item in
                    ToDoViewItem(todo: item)
                        .onTapGesture {
                            let data = SelectedToDoScreenType(selectedToDo: item)
                            navStack.presentedScreen.append(data)
                            todoViewModal.selectedTodo = item
                        }
                    }
                .refreshable {
                    getUserNotes()
                }
            }
            .onAppear {
                getUserNotes()
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
                            getUserNotes()
                        }) {
                            Text("Logout")
                        }
                    }
            )
            .navigationDestination(for: SelectedToDoScreenType.self) { type in
                SelectedToDo()
            }
        }
    }
    
    
    func getUserNotes() {
        ToDoServices().getUserToDo(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                print("Get Todo done")
                toDoList = data
            case .failure(let error):
                print("Error man")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("Error")
                    print(errorMessage)
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
            ToDoList()
                .environmentObject(ToDoNavigationStackViewModal())
                .environmentObject(ToDoViewModal())
    }
}
