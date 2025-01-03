//
//  UserProfileView.swift
//  MyToDo
//
//  Created by Girish Parate on 03/01/25.
//

import SwiftUI
import PhotosUI
import NetworkImage
import SwiftEmailValidator

struct UserProfileView: View {
    
    var onDelete: (() -> Void)
    var file: File?
    
    var body: some View {
        Section {
            if(file == nil){
                Text("No Profile Image")
            } else {
                VStack {
                    NetworkImage(url: URL(string: AppConst.todoimagesPath + (file?.fileName ?? ""))) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ZStack {
                            Color.secondary.opacity(0.25)
                            Image(systemName: "photo.fill")
                                .imageScale(.large)
                                .blendMode(.overlay)
                        }
                    }
                    HStack {
                        Button("Delete Image") {
                            onDelete()
                        }
                        .buttonStyle(.automatic)
                        .foregroundColor(.red)
                        .padding(.top,6)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Form {
                UserProfileView(
                    onDelete: {
                        
                    }, file: File(fileID: "12", fileName: "File Name", fileSize: "12.3", type: "TYPE", createdAt: "", updatedAt: "", toDoID: "", userID: "")
                )
                .navigationTitle("Your Screen")
            }
        }
        
    }
}
