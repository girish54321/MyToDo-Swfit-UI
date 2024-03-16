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
    
//    @StateObject var appViewModel = AppViewModel()
    
//    @StateObject var firstObject = FirstObservableObject()
//    @StateObject var secondObject: SecondObservableObject
//
//    init() {
//        let secondObject = SecondObservableObject(firstObservableObject: FirstObservableObject())
//        _secondObject = StateObject(wrappedValue: secondObject)
//    }
    
    
    var body: some Scene {
        WindowGroup {
            if isSkipped == true || token != "" {
                HomeMain()
                    .environmentObject(AppViewModel())
                    .environmentObject(AuthViewModel())
//                    .environmentObject(ToDoViewModal(appViewModel: appViewModel))
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
