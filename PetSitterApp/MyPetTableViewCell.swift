//
//  MyPetTableViewCell.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import UIKit

class MyPetTableViewCell: UITableViewCell {

    @IBOutlet weak var petName: UILabel!

    @IBOutlet weak var petImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
           super.layoutSubviews()
           
       }

}
