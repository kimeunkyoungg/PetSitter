//
//  MySitterViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/17/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


//돌봄 내역 화면
class MySitterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var reservations : [MyReservation]=[]
    var db : Firestore!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sitterCell", for: indexPath) as!MySitterTableViewCell
        
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

    //시터 내역 firebase로부터 가져오기
    func fetchReservations() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let sitterID = currentUser.uid
        
        db.collection("reservation").whereField("sitterID", isEqualTo: sitterID).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            self.reservations = []
            
            let group = DispatchGroup()
            
            for document in documents {
                let data = document.data()
                let userID = data["userID"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let time = data["time"] as? String ?? ""
                let reservationTime = data["reservationTime"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                
                group.enter()
                self.fetchUserName(userID: userID) { userName in
                    let reservation = MyReservation(sitterName: userName, date: date, time: time, reservationTime: reservationTime, address: address)
                    self.reservations.append(reservation)
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self.tableView.reloadData()
            }
        }
        
    }
    //보호자 이름 가져오기
    func fetchUserName(userID: String, completion: @escaping (String) -> Void) {
        db.collection("userInfo").document(userID).getDocument { (document, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion("Unknown")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let userName = data?["name"] as? String ?? "Unknown"
                completion(userName)
            } else {
                completion("Unknown")
            }
        }
        
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
    


}
