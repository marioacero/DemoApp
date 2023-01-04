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
    @DecodableBool var isFav: Bool
}


@propertyWrapper
struct DecodableBool {
    var wrappedValue = false
}

extension DecodableBool: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Bool.self)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: DecodableBool.Type,
                forKey key: Key) throws -> DecodableBool {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}
