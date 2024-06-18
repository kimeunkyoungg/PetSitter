//
//  MyReservationViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/17/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//펫시터 예약 내역
class MyReservationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var reservations: [MyReservation] = []
    var db : Firestore!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationCell", for: indexPath) as!MyReservationTableViewCell
        
        let reservation = reservations[indexPath.row]
               
        cell.sitterName.text = reservation.sitterName
        cell.address.text = reservation.address
        cell.time.text = reservation.time
        cell.date.text = reservation.date
        cell.reservationTime.text = reservation.reservationTime
               
        
       
        return cell
    }
    
    
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
        
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchReservations()
        // Do any additional setup after loading the view.
    }
    
    //예약 내역 firebase로부터 가져오기
    func fetchReservations() {
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            
            let userID = currentUser.uid
            db.collection("reservation").whereField("userID", isEqualTo: userID).getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                self?.reservations = []
                
                let group = DispatchGroup()
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let sitterID = data["sitterID"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let reservationTime = data["reservationTime"] as? String ?? ""
                    let address = data["address"] as? String ?? ""
                    
                    group.enter()
                    self?.fetchSitterName(sitterID: sitterID) { sitterName in
                        let reservation = MyReservation(sitterName: sitterName, date: date, time: time, reservationTime: reservationTime, address: address)
                        self?.reservations.append(reservation)
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    self?.tableView.reloadData()
                }
            }
        }
        
    //펫시터 이름 찾아오기
    func fetchSitterName(sitterID: String, completion: @escaping (String) -> Void) {
        db.collection("userInfo").document(sitterID).getDocument { (document, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion("Unknown")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let sitterName = data?["name"] as? String ?? "Unknown"
                completion(sitterName)
            } else {
                completion("Unknown")
            }
        }
        
    }
        


}
