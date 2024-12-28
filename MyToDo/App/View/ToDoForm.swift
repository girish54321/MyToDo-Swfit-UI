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
    
    var imageUrl: String?
    
    var onSubmit: (() -> Void)
    var isUpDate: Bool = true
    
    var body: some View {
        Form {
            Text("Yes!\n\nYou can do it")
            Section {
                TextField("Title", text: $titleText)
                    .textInputAutocapitalization(.never)
                TextField("Body",text: $bodyText)
                    .frame(minHeight: 100)
            }
            Section("Save your todo") {
                Button(isUpDate ? "Update Todo" : "Add Todo") {
                        onSubmit()
                    }
                }
        }
    }
}

struct ToDoForm_Previews: PreviewProvider {
    @State static var titleText: String = ""
    @State static var bodyText: String = ""
    @State static var todoState: String = "OPEN"
    
    @State static var todoImagePicker: PhotosPickerItem?
    @State static var todoImage: Image?

    
    static var previews: some View {
        ToDoForm(titleText: $titleText, bodyText: $bodyText, todoState: $todoState, onSubmit: {
            
        }, isUpDate: false)
    }
}
