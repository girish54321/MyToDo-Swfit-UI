//
//  SelectedToDo.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import SwiftUI

struct SelectedToDo: View {
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal

    @State private var deleteToDo = false
    
    var body: some View {
        List {
            Section("Title") {
                Text(todoViewModal.selectedTodo?.title ?? "NA")
            }
            Section {
                Text(todoViewModal.selectedTodo?.body ?? "NA")
            }
            .alert(isPresented: $deleteToDo) {
                Alert(title: Text("Delete?"),
                      message: Text("Are you sure you want to Delete?."),
                      primaryButton: .destructive(Text("Yes")) {
                    deleteMyToDo()
                }, secondaryButton: .cancel())
            }
            .navigationBarItems(
                trailing:
                    HStack {
                        Button(action: {
                            let data = EditToDoScreenType(selectedToDo: todoViewModal.selectedTodo)
                            navStack.presentedScreen.append(data)
                        }) {
                            Image(systemName: AppIconsSF.editIcon)
                        }
                        Button(action: {
                            deleteToDo.toggle()
                        }) {
                            Image(systemName: AppIconsSF.removeIcon)
                                .foregroundColor(.red)
                        }
                    }
            )
            .navigationTitle(todoViewModal.selectedTodo?.title ?? "NA")
        }
    }
    
    func deleteMyToDo () {
        appViewModel.toggle()
        ToDoServices().deleteToDo(parameters: nil, endpoint: String(todoViewModal.selectedTodo?.id ?? 1)) {
            result in
            switch result {
            case .success(let data):
                appViewModel.toggle()
                if(data.deleted == true) {
                    navStack.presentedScreen.removeLast()
                } else {
                    appViewModel.errorMessage = "Can't delete ToDo."
                }
            case .failure(let error):
                print("Error man")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

struct SelectedToDo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SelectedToDo().environmentObject(ToDoViewModal())
                .environmentObject(AppViewModel())
        }
    }
}
