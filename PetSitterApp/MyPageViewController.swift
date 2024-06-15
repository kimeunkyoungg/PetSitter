//
//  MyPageViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/11/24.
//

import UIKit

class MyPageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //let menuItems = ["내 반려동물" , "예약 내역"]
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
           return 180 // 모든 셀의 높이를 100으로 설정
       }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            if let petManagementVC = storyboard?.instantiateViewController(withIdentifier: "PetManagementViewController") {
                navigationController?.pushViewController(petManagementVC, animated: true)
            }
        case 1:
            if let reservationHistoryVC = storyboard?.instantiateViewController(withIdentifier: "ReservationViewController") {
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
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) // 위쪽 간격 설정
        // Do any additional setup after loading the view.
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
