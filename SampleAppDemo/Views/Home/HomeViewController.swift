//
//  HomeViewController.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var viewModel : HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
    }
    
    
}
