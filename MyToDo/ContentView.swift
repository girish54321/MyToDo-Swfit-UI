//
//  ContentView.swift
//  MyToDo
//
//  Created by Girish Parate on 08/03/24.
//


import SwiftUI

@main
struct ContentView: App {
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    
    var body: some Scene {
        WindowGroup {
            if isSkipped == true || token != "" {
                HomeMain()
                    .environmentObject(AppViewModel())
                    .environmentObject(AuthViewModel())
                    .environmentObject(ToDoViewModal())
                    .environmentObject(ToDoNavigationStackViewModal())
                    .environmentObject(ProfileNavigationStackViewModal())
               
            } else {
                AuthMainView()
                    .environmentObject(AppViewModel())
                    .environmentObject(AuthViewModel())
            }
        }
    }
}
