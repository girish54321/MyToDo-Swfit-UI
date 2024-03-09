//
//  DataModel.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

//  DataModel.swift
import Foundation

struct DataModel: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

class SampleData {
    static let authItem = [
        DataModel(text: "Login"),
        DataModel(text: "Create Acccount"),
        DataModel(text: "Info"),
    ]
    
    static let firstScreenData = [
        DataModel(text: "🚂 Trains"),
        DataModel(text: "✈️ Planes"),
        DataModel(text: "🚗 Automobiles"),
    ]
    
    static let secondScreenData = [
        DataModel(text: "Slow"),
        DataModel(text: "Regular"),
        DataModel(text: "Fast"),
    ]
    
    static let lastScreenData = [
        DataModel(text: "Wrong"),
        DataModel(text: "So-so"),
        DataModel(text: "Right"),
    ]
}
