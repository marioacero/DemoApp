//
//  Comment.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-03.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
