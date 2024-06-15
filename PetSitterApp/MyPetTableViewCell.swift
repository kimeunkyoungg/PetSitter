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
        setupBorder()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
           super.layoutSubviews()
           
       }
    private func setupBorder() {
        self.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상
        self.layer.borderWidth = 1.0 // 테두리 두께
        self.layer.cornerRadius = 8.0 // 테두리 둥글기 (옵션)
        self.clipsToBounds = true // 둥근 테두리를 설정할 때 사용
        
    }
}
