//
//  HomeMain.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct HomeMain: View {
    @State private var firstSelectedDataItem: DataModel?
    @State private var secondSelectedDataItem: DataModel?
    @State private var thirdSelectedDataItem: DataModel?
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        #if targetEnvironment(macCatalyst)
        NavigationSplitView {
//            List {
//                Text("ToDo")
//                Text("Add New")
//                Text("Profile")
//            }
            ToDoList()
            .navigationTitle("ToDo")
        }
//    content: {
//            ToDoList()
//        }
    detail: {
            CreateToDo()
        }
        .toast(isPresenting: $appViewModel.show){
            appViewModel.alertToast
        }
        .alert(isPresented: $appViewModel.showAlert) { () -> Alert in
            Alert(title: Text("Error"), message: Text(appViewModel.errorMessage))
        }
        .safeAreaInset(edge: .bottom) {
        }
        #else
        TabView (selection: $appViewModel.slectedTabIndex) {
            ToDoList()
            .tabItem {
                Image(systemName: AppIconsSF.homeIcon)
                Text("ToDo")
            }
            .tag(0)
            CreateToDo()
                .tabItem {
                    Image(systemName: AppIconsSF.trandingIcon)
                    Text("Add New")
                }
                .tag(1)
           UserProfile()
                .tabItem {
                    Image(systemName: AppIconsSF.userIcon)
                    Text("Profile")
                }
                .tag(2)
        }
        .alert(isPresented: $appViewModel.showAlert) { () -> Alert in
            Alert(title: Text("Error"), message: Text(appViewModel.errorMessage))
        }
        .toast(isPresenting: $appViewModel.show){
            appViewModel.alertToast
        }
        .onAppear{
            appViewModel.alertToast = AppMessage.loadingView
            appViewModel.show.toggle()
        }
        #endif
    }
}

struct HomeMain_Previews: PreviewProvider {
    static var previews: some View {
        HomeMain()
            .environmentObject(AppViewModel())
            .environmentObject(ToDoNavigationStackViewModal())
    }
}
