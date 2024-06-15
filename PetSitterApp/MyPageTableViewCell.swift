//
//  MyPageTableViewCell.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/13/24.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {

    @IBOutlet weak var myPageImage: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
