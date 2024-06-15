//
//  PostTableViewCell.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
