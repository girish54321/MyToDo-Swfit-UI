//
//  ApiError.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
import Alamofire

struct ApiError {
    func handleError<T: Decodable>(response: DataResponse<T, AFError>, completion: (Result<T, Error>) -> Void) {
        switch response.result {
        case .success(let value):
            completion(.success(value))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private static func CheckApiError(response: HTTPURLResponse?) -> Bool{
        if response?.statusCode == 200 || response?.statusCode == 201 {
            return true;
        } else {
            return true
        }
    }
    
    static func checkApiError(response: HTTPURLResponse?) -> Bool{
        return CheckApiError(response: response)
    }
}

func createApiErrorMessage(errorCase: NetworkError) -> String {
    switch errorCase {
    case .NetworkErrorAPIError(let errorMessage):
        return errorMessage
    case .BadURL:
        return "Bad URL"
    case .NoData:
        return "No Data Error"
    case .DecodingError:
        return "JSON Decoding Error"
    }
}

// MARK: - AppErrorRespons
struct AppErrorRespons: Codable {
    let errors: Errors
}

// MARK: - Errors
struct Errors: Codable {
    let body: [String]
}


