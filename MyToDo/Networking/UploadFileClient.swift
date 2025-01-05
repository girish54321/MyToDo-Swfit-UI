//
//  UploadFileClient.swift
//  MyToDo
//
//  Created by Girish Parate on 02/01/25.
//
import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

class UploadFileClient {
    static func request<T: Codable>(type: T.Type,
                                    endPoint: String,
                                    multipartFormData: @escaping (MultipartFormData) -> Void,
                                    parameters: Parameters? = nil,
                                    completion: @escaping(Result<T,NetworkError>) -> Void,
                                    costumeCompletion: ((HTTPURLResponse?) -> Void)? = nil) {
        // Token
        @AppStorage(AppConst.token) var token: String = ""
        // Crate URL
        let encodedURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        // Crate Header with Token
        var headers: HTTPHeaders? = nil
        if(token != ""){
            headers = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        } else {
            headers = nil
        }
        
        @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
        @AppStorage(AppConst.token) var storeageToken: String = ""
        
            //    UnCommet for Debug
               print("DEBUG Only")
               print("API EndPoint")
               print(encodedURL)
               print("Tokan")
               print("Bearer \(token)")
               print(parameters)
        
        AF.upload(
            multipartFormData: multipartFormData, to: encodedURL,headers: headers)
        .validate() // Optional: Validate the response
        .response { response in
            ApiError().handleError(response: response) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        // if CallBack needed
                        if (costumeCompletion != nil) {
                            costumeCompletion!(response.response)
                            return
                        }
                        // Get Request Status
                        let statusCode = response.response?.statusCode
                        print("1")
                        // Handle Stacific Status code
                        if(statusCode == 204){
                            print("2")
                            completion(.success("Done" as! T))
                            return
                        }
                        
                        if(statusCode == 401){
                            isSkipped = false
                            storeageToken = ""
                            completion(.failure(.NoData))
                            return
                        }
                        
                        // Default Status
                        if(statusCode == 200 || statusCode == 201){
                            let result = response.result
                            switch result {
                            case .success(let data):
                                // If No data in Response
                                guard let data = data else {
                                    completion(.failure(.NoData))
                                    return
                                }
                                // JSON TO Types
                                guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                                    completion(.failure(.DecodingError))
                                    return
                                }
                                // Pass Success with response Type
                                completion(.success(obj))
                            case .failure(let error):
                                completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                            }
                        } else {
                            print("JSON EROR OLD")
                            // If Error
                            guard let jsonData = response.data else {
                                completion(.failure(.DecodingError))
                                return
                            }
                            print("Error JSON")
                            print(jsonData)
                            // JSON TO Types
                            guard let obj = try? JSONDecoder().decode(NetworkErrorC.self, from: jsonData) else {
                                completion(.failure(.DecodingError))
                                return
                            }
                            // Pass Error with default Error Type
                            completion(.failure(.NetworkErrorAPIError(obj.error?.message ?? "Error")))
                            return
                            
                        }
                    }
                case .failure(let error):
                    print("1222")
                    guard let jsonData = response.data else {
                        completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                        return
                    }
                    guard let obj = try? JSONDecoder().decode(NetworkErrorC.self, from: jsonData) else {
                        completion(.failure(.DecodingError))
                        return
                    }
                    completion(.failure(.NetworkErrorAPIError(obj.error?.message ?? error.localizedDescription)))
                }
            }
            
        }
        
    }
    
}
