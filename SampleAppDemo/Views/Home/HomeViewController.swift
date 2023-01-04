//
//  HomeViewController.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentIndex: Int = 0
    
    private var viewModel : HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        tableView.registerNib(HomeTableViewCell.stringRepresentation)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        viewModelBind()
    }
    
    func viewModelBind() {
        viewModel.posts.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
        viewModel.fetchPosts()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! DetailsViewController
        controller.post = (sender as! Post)
        controller.delegate = self
    }
    
    @IBAction func showActions(_ sender: Any) {
        let alert = UIAlertController(title: "Custom Actions", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Reload all posts", style: .default , handler:{ (UIAlertAction)in
                self.viewModel.fetchPosts()
            }))

            alert.addAction(UIAlertAction(title: "Remove no favorites posts", style: .destructive , handler:{ (UIAlertAction)in
                self.viewModel.removeNoFavItems()
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            
            //uncomment for iPad Support
            //alert.popoverPresentationController?.sourceView = self.view

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "detailsScreen", sender: viewModel.posts.value[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.value.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTableViewCell =
            tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.stringRepresentation, for: indexPath) as! HomeTableViewCell
        let post = viewModel.posts.value[indexPath.row]
        cell.title.text = post.title
        cell.favImage.isHidden = !post.isFav
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        viewModel.posts.value.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

extension HomeViewController: DetailsDelegate {
    func addTofavorites(id: Int) {
        viewModel.posts.value[currentIndex].isFav = !viewModel.posts.value[currentIndex].isFav
        let sorted = viewModel.posts.value.sorted{
            $0.isFav && !$1.isFav
        }
        
        viewModel.posts.value = sorted
    }
}
