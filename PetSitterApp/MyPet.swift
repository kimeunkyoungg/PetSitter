//
//  MyPet.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import Foundation
import UIKit

class MyPet {
    var petName: String
    var petImageURL: String?
    var petImage: UIImage?
    var age: String
    var kind: String
    var sex: String
    var weight: String
    
    init(petName: String, petImageURL: String?, age: String, kind: String, sex: String, weight: String) {
        self.petName = petName
        self.petImageURL = petImageURL
        self.age = age
        self.kind = kind
        self.sex = sex
        self.weight = weight
    }
    
    static var myPetList: [MyPet] = []
}
