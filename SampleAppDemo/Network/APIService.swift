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
    
    func getPosts(completion: @escaping ([Post]) -> Void) {
        provider.request(.getPosts) { (result) in
            switch result {
            case .success(let response):
                let posts = self.mapper.mapPosts(dataResponse: response.data)
                return completion(posts)
            case .failure(let error):
                print(error)
                return completion([])
            }
        }
    }
    
    func getUserDetails(id: Int, completion: @escaping (User?) -> Void) {
        provider.request(.getUser(id: id)) { result in
            switch result {
            case .success(let response):
                let user = self.mapper.mapUser(dataResponse: response.data)
                return completion(user)
            case .failure(let error):
                print(error)
                return completion(nil)
            }
        }
    }
    
    func getCommentsByPostId(id: Int, completion: @escaping ([Comment]) -> Void) {
        provider.request(.getComments(postId: id)) { result in
            switch result {
            case .success(let response):
                let comments = self.mapper.mapComments(dataResponse: response.data)
                return completion(comments)
            case .failure(let error):
                print(error)
                return completion([])
            }
        }
    }
}
