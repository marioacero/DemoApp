//
//  API.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation
import Moya
import Alamofire

enum API {
    case getPosts
}


extension API: TargetType {
    var baseURL: URL {
        guard let url: URL = URL(string: Constants.baseUrl) else{
            fatalError(Constants.Errors.baseUrl)
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getPosts:
            let endPoint = Constants.posts
            return endPoint
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var failureData: Data {
        return "{failure data}".data(using: String.Encoding.utf8)!
    }
    
    
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
