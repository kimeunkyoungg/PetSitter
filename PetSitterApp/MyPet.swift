//
//  MyPet.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import Foundation
import UIKit

class MyPet {
    var petName : String
    var petImage : UIImage?
    
    init(petName : String, petImage : UIImage?){
        self.petName=petName
        self.petImage=petImage
    }
    
    static var myPetList: [MyPet]=[MyPet(petName: "대봉", petImage: UIImage(named: "bong")), MyPet(petName: "살구", petImage: UIImage(named: "salgu"))
    
    ]
}
