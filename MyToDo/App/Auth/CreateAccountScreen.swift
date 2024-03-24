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

    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack (spacing: 14) {
            VStack(alignment: .center,spacing: 8) {
                Text("Wlcome to My ToDo")
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
            AppButton(text: screenType.isCreateAccount ?? true ? "Sign Up": "Login", clicked: {
                    if(screenType.isCreateAccount == true) {
                        createAccout()
                    }else{
                        UserLoginApi(email: emailText, password: passwordText)
                    }
                }
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
    
    func toggleLoginState()  {
        withAnimation {
            screenType.isCreateAccount = !(screenType.isCreateAccount ?? false)
        }
    }
    
    func createAccout () {
        appViewModel.alertToast = AppMessage.loadingView
        let authParams = UserAuthParams(firstName: firstName, lastName: lastName, email: emailText, password: passwordText)
        AuthServices().createAccount(parameters: authParams.toDictionary()) {
            result in
            switch result {
            case .success(let data):
                appViewModel.toggle()
                withAnimation {
                    token = data.accessToken
                }
                authViewModel.saveUser(data: data)
            case .failure(let error):
                print("Create Account Error")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
    
    func UserLoginApi(email : String,password : String) {
        appViewModel.alertToast = AppMessage.loadingView
        let authParams = UserAuthParams(email: email, password: password)
        AuthServices().userLogin(parameters: authParams.toDictionary()) {
            result in
            switch result {
            case .success(let data):
                appViewModel.toggle()
                withAnimation {
                    token = data.accessToken
                }
                authViewModel.saveUser(data: data)
            case .failure(let error):
                print("Create Account Error")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
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
