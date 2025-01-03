//
//  UserProfile.swift
//  MyToDo
//
//  Created by Girish Parate on 03/01/25.
//


import SwiftUI
import PhotosUI
import NetworkImage
import SwiftEmailValidator

struct UserProfileImage: View {
    
    var file: File?
    
    var userName: String?
    var lastName: String?
    var userEmail: String?
    
    var body: some View {
        Section {
            VStack (alignment: .leading){
                HStack {
                    VStack (alignment: .leading, spacing: 16) {
                        HStack {
                            Text(userName ?? "")
                            Text(lastName ?? "")
                        }
                        Text(userEmail ?? "")
                    }
                    Spacer()
                    NetworkImage(url: URL(string: AppConst.todoimagesPath + (file?.fileName ?? ""))) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ZStack {
                            Color.secondary.opacity(0.25)
                            Image(systemName: "photo.fill")
                                .imageScale(.large)
                                .blendMode(.overlay)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .clipped()
                    .clipShape(Circle())
                }
            }
        }
    }
}

struct UserProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Form {
                UserProfileImage(
                    file: File(fileID: "12", fileName: "File Name", fileSize: "12.3", type: "TYPE", createdAt: "", updatedAt: "", toDoID: "", userID: ""), userName: "Girish",
                    lastName: "Parate",
                    userEmail: "girish@gmail.com"
                )
                .navigationTitle("Your Screen")
            }
        }
        
    }
}
