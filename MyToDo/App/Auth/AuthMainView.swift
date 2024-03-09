//
//  AuthMainView.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI
import AlertToast

struct AuthMainView: View {
    @State private var authItem: DataModel? = SampleData.authItem[0]
    @State private var secondSelectedDataItem: DataModel?
    @State private var thirdSelectedDataItem: DataModel?
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        #if targetEnvironment(macCatalyst)
        NavigationSplitView {
            List(SampleData.authItem, selection: $authItem) { item in
                NavigationLink(item.text, value: item)
            }
            .navigationTitle("Auth")
        } detail: {
            CreateAccountScreen()
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
        NavigationStack {
            CreateAccountScreen()
        }
        .toast(isPresenting: $appViewModel.show){
            appViewModel.alertToast
        }
        .alert(isPresented: $appViewModel.showAlert) { () -> Alert in
            Alert(title: Text("Error"), message: Text(appViewModel.errorMessage))
        }
        .safeAreaInset(edge: .bottom) {
        }
        #endif
    }
}

struct AuthMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainView()
    }
}
