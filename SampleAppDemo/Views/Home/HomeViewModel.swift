//
//  HomeViewModel.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation

class HomeViewModel: NSObject {
    private var api: ApiService
    override init() {
        api = ApiService()
        api.getPosts()
    }
}
