//
//  Extensions.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-03.
//

import Foundation
import UIKit

extension UITableView {
    
    internal func registerNib(_ nibName: String) {
        let cellNib = UINib.init(nibName: nibName, bundle: nil)
        register(cellNib, forCellReuseIdentifier: nibName)
    }
}


extension NSObject {
    
    class var stringRepresentation: String {
        let name = String(describing: self)
        return name
    }
}
