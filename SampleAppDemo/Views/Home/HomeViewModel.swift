//
//  HomeViewModel.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation

class HomeViewModel: NSObject {
    
    private var api: ApiService
    var posts: Observable<[Post]> = Observable([])
    
    override init() {
        api = ApiService()
    }
    
    func fetchPosts() {
        api.getPosts { [weak self] result in
            self?.posts.value = result
        }
    }
    
    func removeNoFavItems() {
        let favItems = posts.value.filter{
            $0.isFav == true
        }
        posts.value = favItems
    }
}
