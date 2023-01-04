//
//  DetailsViewModel.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation

class DetailsViewModel: NSObject {
    
    var post: Post!
    var user: Observable<User?> = Observable(nil)
    var comments: Observable<[Comment]> = Observable([])
    private var api: ApiService
    
    override init() {
        api = ApiService()
    }
    
    func fetchUserDetails(userId: Int) {
        api.getUserDetails(id: userId) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.user.value = result
        }
    }
    
    func fetchPostComments(postId: Int) {
        api.getCommentsByPostId(id: postId) { [weak self] comments in
            guard let strongSelf = self else { return }
            strongSelf.comments.value = comments
        }
    }
    
}
