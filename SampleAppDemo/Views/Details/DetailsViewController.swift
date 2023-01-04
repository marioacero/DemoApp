//
//  DetailsViewController.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import UIKit

protocol DetailsDelegate: AnyObject {
    func addTofavorites(id: Int)
}

class DetailsViewController: UIViewController {
    

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var post: Post!
    var viewModel: DetailsViewModel!
    
    weak var delegate: DetailsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailsViewModel()
        titleLabel.text = post.title
        descriptionLabel.text = post.body
        tableView.registerNib(CommentsTableViewCell.stringRepresentation)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        updateFavIcon()
        setViewModelBinding()
    }
    
    func setViewModelBinding() {
        viewModel.user.bind { [weak self] user in
            guard let strongSelf = self else { return }
            if let userObject = user {
                strongSelf.authorName.text = """
                    Name: \(userObject.name)
                    User name: \(userObject.username)
                    Email: \(userObject.email)
                    """
            }
            
        }
        
        viewModel.comments.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
            strongSelf.tableView.reloadData()
            strongSelf.tableView.layoutIfNeeded()
            strongSelf.tableViewHeight.constant = strongSelf.tableView.contentSize.height
        }
        viewModel.fetchUserDetails(userId: post.userId)
        viewModel.fetchPostComments(postId: post.id)
    }

    @objc func addToFav() {
        var title = "Add to Favorites"
        var message = "Do you want to add  this post to your favorites?"
        if (post.isFav) {
            title = "Remove from Favorites"
            message = "Are you sure?"
        }
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.post.isFav = !self.post.isFav
            self.updateFavIcon()
            self.delegate?.addTofavorites(id: self.post.id)
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func updateFavIcon() {
        var image = "heart"
        if (post.isFav) {
            image = "heart.fill"
        }
        let button = UIBarButtonItem(image: UIImage(systemName: image) , style: .plain, target: self, action: #selector(self.addToFav))
        self.navigationItem.rightBarButtonItem  = button
    }
    
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.value.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CommentsTableViewCell =
            tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.stringRepresentation, for: indexPath) as! CommentsTableViewCell
        let comment = viewModel.comments.value[indexPath.row]
        cell.titleLabel.text = comment.name
        cell.emailLabel.text = comment.email
        cell.bodyLabel.text = comment.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments (\(viewModel.comments.value.count))"
    }
}
