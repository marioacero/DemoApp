//
//  Constants.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation

struct Constants {
    
    static let baseUrl: String = "https://jsonplaceholder.typicode.com/"
    static let posts: String = "posts"
    static let user: String = "users/%i"
    static let comments: String = "posts/%i/comments"
    
    struct Errors {
        static let baseUrl: String = "baseURL could not be configured."
        static let errorMapping: String = "Error Mapping"
    }
}
