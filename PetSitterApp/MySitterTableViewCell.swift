//
//  MySitterTableViewCell.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/17/24.
//

import UIKit

class MySitterTableViewCell: UITableViewCell {


    @IBOutlet weak var sitterName: UILabel!
    
    @IBOutlet weak var reservationTime: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
