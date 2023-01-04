//
//  User.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-03.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let website: String
    let address: Address
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}
