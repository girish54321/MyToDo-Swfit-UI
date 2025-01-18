//
//  ErrorMessageView.swift
//  MyToDo
//
//  Created by Girish Parate on 28/12/24.
//

import SwiftUI

struct ErrorMessageView: View {
    var errorMessage: String?
    var smallView: Bool? = false
    var clicked: (() -> Void)
    
    var body: some View {
        if(smallView ?? false){
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                    .font(.system(size: 34))
                Text(errorMessage ?? "")
                    .font(.headline)
                Spacer()
                    Button(action: clicked) {
                        Text("Try Agine")
                    }
                    .buttonStyle(.bordered)
            }
            .padding(.horizontal)
        }else {
            VStack(spacing: 18) {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                    .font(.system(size: 72))
                Text(errorMessage ?? "")
                    .font(.headline)
                HStack {
                    AppButton(text: "Try Agine", clicked: clicked)
                }
                .frame(width:150)
            }
        }
    }
}

#Preview {
    var errorMessage = "Your Error Message"
    VStack {
        ErrorMessageView(
            errorMessage: errorMessage,
            smallView: false
        ) {
            
        }
        ErrorMessageView(
            errorMessage: errorMessage,
            smallView: true
        ) {
            
        }
    }
}
