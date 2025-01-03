//
//  ToDoEndpoint.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
class ToDoApiEndpoint {
    
    enum ToDoApiType {
        case getToDo
        case getSelectedTodo
        case addTodo
        case delete
        case updateTodo
    }
    
    func createEndPoint(endPoint: ToDoApiType) -> String {
        switch endPoint {
        case .getToDo:
            return createApi(endPoint: "todo/getalltodos")
        case .addTodo:
            return createApi(endPoint: "todo/addtodo")
        case .delete:
            return createApi(endPoint: "todo/deletetodo/")
        case .updateTodo:
            return createApi(endPoint: "todo/updatetodo")
        case .getSelectedTodo:
            return createApi(endPoint: "todo/gettodo/")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
