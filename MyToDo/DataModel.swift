//
//  DataModel.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

//  DataModel.swift
import Foundation

enum MainHomeScreeType {
    case home
    case profile
    case createTodo
}

struct DataModel: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let type: MainHomeScreeType
}

class ToDoStatuList {
    static let todoStatus = [
        ToDoStatu(text: "ToDo", type: "OPEN"),
        ToDoStatu(text: "In-Progress", type: "In-Progress"),
        ToDoStatu(text: "Done", type: "DONE"),
    ]
}
struct ToDoStatu: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let type: String
}

class MainHomeData {
    static let homeData = [
        DataModel(text: "Home",type: MainHomeScreeType.home),
        DataModel(text: "Create ToDo",type: MainHomeScreeType.createTodo),
        DataModel(text: "Profile",type: MainHomeScreeType.profile),
    ]
}


class SampleData {
    static let authItem = [
        DataModel(text: "Login",type: MainHomeScreeType.home),
        DataModel(text: "Create Acccount",type: MainHomeScreeType.home),
        DataModel(text: "Info",type: MainHomeScreeType.home),
    ]

}
