//
//  MyPageViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/11/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//마이페이지 화면

class MyPageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var db: Firestore!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyPage.myPageList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPageCell", for: indexPath) as!MyPageTableViewCell
        
        let target = MyPage.myPageList[indexPath.row]
        
        cell.title.text=target.title
        cell.content.text=target.content
        cell.myPageImage.image = target.image
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 180
       }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            if let petManagementVC = storyboard?.instantiateViewController(withIdentifier: "PetManagementViewController") {
                navigationController?.pushViewController(petManagementVC, animated: true)
            }
        case 1:
            if let reservationHistoryVC = storyboard?.instantiateViewController(withIdentifier: "MyReservationViewController") {
                navigationController?.pushViewController(reservationHistoryVC, animated: true)
            }
            
        case 2:
            if let reservationHistoryVC = storyboard?.instantiateViewController(withIdentifier: "MySitterViewController") {
                navigationController?.pushViewController(reservationHistoryVC, animated: true)
            }
        default:
            break
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) // 위쪽 간격 설정
       
        db = Firestore.firestore()
        // 로그인된 사용자의 이름 가져오기
               if let user = Auth.auth().currentUser {
                   let userID = user.uid
                   let userInfo = db.collection("userInfo").document(userID)
                   userInfo.getDocument { (document, error) in
                       if let document = document, document.exists {
                           let dataDescription = document.data()
                           let userName = dataDescription?["name"] as? String
                           self.userNameLabel.text = userName
                       } else {
                           print("없음")
                       }
                   }
               }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        try? Auth.auth().signOut()
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            let navController = UINavigationController(rootViewController: loginVC)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            
        }
    
        
    
    }
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
