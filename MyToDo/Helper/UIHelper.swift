//
//  UIHelper.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
import SwiftUI
import AlertToast
//import HTMLEntities

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .serif))
            .padding(8)
    }
}

extension Text {
    func appTextStyle() -> some View {
        self
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color.accentColor)
    }
}

extension VStack {
    func inputTextStyle() -> some View {
        self
            .background(
                Rectangle()
                    .fill(Color.gray.opacity(0.05))
                    .frame(height: 55)
                    .cornerRadius(4)
            )
    }
}

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
//            .scaledToFit()
            .scaledToFill()
    }
    
    func imageModifierCircle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
    
    func iconModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
    
    func inputIconStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
    }
}

struct AppMessage {
    static let loadingView = AlertToast(type: .loading, title: "Loading")
}

struct UIHelper {
    
//    func formateHelptext(text: String) -> String {
//        return text.htmlUnescape()
//    }
    
}


extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
