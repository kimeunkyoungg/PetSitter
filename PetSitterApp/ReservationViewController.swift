//
//  ReservationViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/13/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//펫시터 예약 화면
class ReservationViewController: UIViewController {

    @IBOutlet weak var reservationTimeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addressTextField: UITextField!
    
    var db : Firestore!
    var sitterID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
      
       
    }
    
    @IBAction func finishReservationButtonPressed(_ sender: UIButton) {
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid
        let reservationTime = reservationTimeTextField.text ?? ""
        let address = addressTextField.text ?? ""
        
        // DatePicker에서 날짜와 시간을 분리하기
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: selectedDate)
        
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: selectedDate)
        
        guard let sitterID = sitterID else {
            return
        }
        
        let reservationData: [String: Any] = [
            "userID": userID,
            "sitterID": sitterID,
            "date": date,
            "time": time,
            "address": address,
            "reservationTime": reservationTime
        ]
        
        db.collection("reservation").addDocument(data: reservationData) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else {
                
                if let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                    // Replace the current navigation stack with the tab bar controller
                    self.navigationController?.setViewControllers([tabBarVC], animated: true)
                }
            }
        }
        
    }

}
