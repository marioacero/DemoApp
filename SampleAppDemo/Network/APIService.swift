//
//  APIService.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation
import Moya

protocol Network {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

typealias APICustomClosure = (API) -> Endpoint

class ApiService: Network {
    
    var provider: MoyaProvider<API>
    var mapper: Mapper = Mapper()
    required init(customClosure: APICustomClosure? = nil) {
        provider = MoyaProvider<API> (plugins: [NetworkLoggerPlugin()])
    }
    
    func getPosts() {
        provider.request(.getPosts) { (result) in
            switch result {
            case .success(let response):
                let posts = self.mapper.mapPosts(dataResponse: response.data)
                print(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
}
