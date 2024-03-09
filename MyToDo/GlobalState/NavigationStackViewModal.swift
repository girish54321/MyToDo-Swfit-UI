//
//  NavigationStackViewModal.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
import SwiftUI

class ToDoNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}

class TradingNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}

class ProfileNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}
