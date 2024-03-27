//
//  SelectedToDo.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import SwiftUI
import SwiftDate

struct SelectedToDo: View {
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal

    @State private var deleteToDo = false
    
    @State var todo: TodoItem = TodoItem()
    
    var body: some View {
        VStack {
            Form {
                Section("Title") {
                    Text(todoViewModal.selectedTodo?.title ?? "NA")
                }
                Section {
                    Text(todoViewModal.selectedTodo?.body ?? "NA")
                }
                Picker("Status", selection: $todo.status.toUnwrapped(defaultValue: "OPEN")) {
                    ForEach(ToDoStatuList.todoStatus) { option in
                        Text(option.text)
                            .tag(option.type)
                    }
                }
                .pickerStyle(.inline)
                Section ("Time Stamp") {
                    HStack {
                        Text("Created At")
                        Spacer()
                        Text(DateHelper().formDate(date: Date(todoViewModal.selectedTodo?.createdAt ?? "")!))
                    }
                    HStack {
                        Text("Update At")
                        Spacer()
                        Text(DateHelper().formDate(date: Date(todoViewModal.selectedTodo?.updatedAt ?? "")!))
                    }
                }
                if (todoViewModal.selectedTodo?.todoImage != nil) {
                    ToToImageView(imageUrl: todoViewModal.selectedTodo?.todoImage ?? "")
                }
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
            .onAppear {
                todo = todoViewModal.selectedTodo!
            }
        }
    }
    
    func deleteMyToDo () {
        appViewModel.toggle()
        todoViewModal.deleteTodo(){
            (data,errorText) -> () in
            appViewModel.toggle()
            if (errorText != nil){
                appViewModel.errorMessage = errorText!
                return
            }
            if(data?.deleted == true) {
                navStack.presentedScreen.removeLast()
                todoViewModal.getUserNotes()
            } else {
                appViewModel.errorMessage = "Can't delete ToDo."
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
