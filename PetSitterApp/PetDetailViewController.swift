//
//  PetDetailViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/18/24.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class PetDetailViewController: UIViewController {
    
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var pet: MyPet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pet = pet else {
            print("Pet 정보가 없습니다.")
            return
        }
        
        nameLabel.text = pet.petName
        ageLabel.text = pet.age
        kindLabel.text = pet.kind
        sexLabel.text = pet.sex
        heightLabel.text = pet.weight
        if let petImage = pet.petImage {
            petImageView.image = petImage
        } else {
            petImageView.image = UIImage(named: "defaultPetImage")
        }
    }

}
