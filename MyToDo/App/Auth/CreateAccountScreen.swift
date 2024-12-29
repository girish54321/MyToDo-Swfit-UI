//
//  CreateAccountScreen.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI


import SwiftUI

struct CreateAccountScreen: View {
    @State var screenType: LoginScreenType = LoginScreenType(title: "Login", isCreateAccount: false)
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack (spacing: 14) {
            VStack(alignment: .center,spacing: 8) {
                Text("Welcome to My ToDo")
                    .appTextStyle()
                Text(screenType.isCreateAccount ?? true ? "Create account to join us." : "Login using Email And Password")
                    .font(.footnote)
            }
            if screenType.isCreateAccount ?? true {
                AppInputBox(
                    leftIcon: AppIconsSF.userIcon,
                    placeHolder: "First Name",
                    keyboard: AppKeyBoardType.default,
                    title:"First Name", value: $firstName
                )
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
            if screenType.isCreateAccount ?? true {
                AppInputBox(
                    leftIcon: AppIconsSF.userIcon,
                    placeHolder: "Last Name",
                    keyboard: AppKeyBoardType.default,
                    title:"Last Name", value: $lastName
                )
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
            AppInputBox(
                leftIcon: AppIconsSF.emailIcon,
                placeHolder: "Email",
                keyboard: AppKeyBoardType.emailAddress,
                title:"Email", value: $emailText
            )
            AppInputBox(
                leftIcon: AppIconsSF.passwordIcon,
                placeHolder: "Password",
                passwordView:  SecureField("Password", text: $passwordText),
                title:"Password", value: $passwordText
            )
            AppButton(
                text: screenType.isCreateAccount ?? true ? "Sign Up": "Login",
                clicked: onButtonTaped
            )
            .padding(.top)
            Spacer()
            Button(action: toggleLoginState) {
                Text(screenType.isCreateAccount ?? true ? "all ready have an account?\nLogin here" : "Don't have an account?\n Create here")
                    .font(.headline)
            }
        }
        .padding()
        .navigationTitle(screenType.isCreateAccount ?? true ? "Create Account":"Login")
    }
    
    func onButtonTaped () {
        if(screenType.isCreateAccount == true) {
            createAccout()
        } else {
            userLoginApi()
        }
    }
    
    func toggleLoginState()  {
        withAnimation {
            screenType.isCreateAccount = !(screenType.isCreateAccount ?? false)
        }
    }
    
    func createAccout () {
        appViewModel.alertToast = AppMessage.loadingView
        let authParams = UserAuthParams(firstName: firstName, lastName: lastName, email: emailText, password: passwordText).toDictionary()
        AuthViewModel().createAccount(parameters: authParams) {
            (data, errorText) -> () in
            appViewModel.toggle()
            if(errorText != nil) {
                appViewModel.errorMessage = errorText!
                return
            }
        }
    }
    
    func userLoginApi() {
        appViewModel.alertToast = AppMessage.loadingView
        let authParams = UserAuthParams(email: emailText, password: passwordText).toDictionary()
        AuthViewModel().loginUser(parameters: authParams) {
            (data, errorText) -> () in
            appViewModel.toggle()
            if(errorText != nil) {
                appViewModel.errorMessage = errorText!
                return
            }
        }
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateAccountScreen()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
                           .previewDisplayName("iPhone 14")
        }
    }
}
