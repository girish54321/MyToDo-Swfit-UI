//
//  NavModal.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation

struct WelcomeScreenType: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

struct LoginScreenType: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var isCreateAccount: Bool?
}

enum AppNavStackType {
    case feed
    case article
    case profile
    case root
}

struct SelectedToDoScreenType: Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: SelectedToDoScreenType, rhs: SelectedToDoScreenType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    let id = UUID()
    var selectedToDo : ToDo?
}
