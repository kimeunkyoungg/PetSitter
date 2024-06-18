//
//  MyReservation.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/17/24.
//

import Foundation
import UIKit

class MyReservation {
    var sitterName : String
    var date : String
    var time : String
    var reservationTime : String
    var address: String
    
    init(sitterName: String, date: String, time: String, reservationTime: String, address: String) {
        self.sitterName = sitterName
        self.date = date
        self.time = time
        self.reservationTime = reservationTime
        self.address = address
    }
    
    static var reservationList: [MyReservation]=[]
}
