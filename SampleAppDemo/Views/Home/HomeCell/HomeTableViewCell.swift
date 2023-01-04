//
//  HomeTableViewCell.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-03.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
