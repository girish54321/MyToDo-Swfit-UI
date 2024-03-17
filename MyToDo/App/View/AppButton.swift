//
//  AppButton.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import SwiftUI

struct AppButton: View {
    
    var text: String
    var leftIcon: Image?
    var rightIcon: Image?
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            HStack {
                leftIcon ?? leftIcon
                Spacer()
                Text(text).fontWeight(.semibold)
                rightIcon ?? rightIcon
                Spacer()
            }
            .frame(height:25)
            .padding(12)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.accentColor, lineWidth: 3)
            )
            .cornerRadius(6)
        }
    }
    
    struct AppButton_Previews: PreviewProvider {
        static var previews: some View {
            AppButton(text: "Login", rightIcon: Image(systemName: "plus"), clicked: {
            }).previewLayout(.sizeThatFits).padding()
            AppButton(text: "Login",rightIcon: Image(systemName: "plus"), clicked: {
            }).previewLayout(.sizeThatFits).padding()
        }
    }
}

struct SkipButton: View {
    var clicked: (() -> Void)
    var body: some View {
        Button(action: clicked){
            Text("Skip").foregroundColor(Color.accentColor).underline()
        }
    }
}
