//
//  Post.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation

struct Post: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
