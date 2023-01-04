//
//  CommentsTableViewCell.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-03.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
