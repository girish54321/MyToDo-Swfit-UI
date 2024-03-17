//
//  ToDoForm.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import SwiftUI
import PhotosUI

struct ToDoForm: View {
    @Binding var titleText: String
    @Binding var bodyText: String
    @Binding var todoState: String
    
    @Binding var avatarItem: PhotosPickerItem?
    @Binding var avatarImage: Image?
    
    var onSubmit: (() -> Void)
    var iSupDate: Bool = true
    
    var body: some View {
        Form {
            Text("Yes!\n\nYou can do it")
            Section {
                TextField("Title", text: $titleText)
                    .textInputAutocapitalization(.never)
                TextField("Place",text: $bodyText)
                     .frame(minHeight: 100)
            }
            Section {
                HStack {
                    PhotosPicker("Select Image", selection: $avatarItem, matching: .images)
                        .task(id: avatarItem) {
                            avatarImage = try? await avatarItem?.loadTransferable(type: Image.self)
                        }
                    Spacer()
                    Image(systemName: AppIconsSF.checkMark)
                        .foregroundColor(.accentColor)
                }
                avatarImage?
                    .resizable()
                    .scaledToFit()
            }
            if iSupDate{
                Picker("Status", selection: $todoState) {
                    ForEach(ToDoStatuList.todoStatus) { option in
                                    Text(option.text)
                                        .tag(option.type)
                                }
                            }
                .pickerStyle(.inline)
            }
            Section("Save your todo") {
                Button(iSupDate ? "Update Todo" : "Add Todo") {
                        onSubmit()
                    }
                }
        }
    }
}

//struct ToDoForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ToDoForm()
//    }
//}
