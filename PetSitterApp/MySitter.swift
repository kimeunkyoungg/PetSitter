//
//  MySitter.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/17/24.
//
import Foundation
import UIKit

class MySitter {
    var userName : String
    var sitterDate : String
    var sitterTime : String
    var reservationTime : String
    var address: String
    
    init(userName: String, sitterDate: String, sitterTime: String, reservationTime: String, address: String) {
        self.userName = userName
        self.sitterDate = sitterDate
        self.sitterTime = sitterTime
        self.reservationTime = reservationTime
        self.address = address
    }

    static var sitterList: [MySitter]=[]
}
