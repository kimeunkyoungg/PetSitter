//
//  PetManageViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/13/24.
//
// 셀 간격 수정 
import UIKit

class PetManageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyPet.myPetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPetCell", for: indexPath) as!MyPetTableViewCell
        
        let target = MyPet.myPetList[indexPath.row]
        
        cell.petName.text=target.petName
        cell.petImage.image = target.petImage
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 130 // 모든 셀의 높이를 100으로 설정
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPetButtonPressed(_ sender: UIButton) {
        if let addPetVc = storyboard?.instantiateViewController(withIdentifier: "AddPetViewController"){
            navigationController?.pushViewController(addPetVc, animated: true)
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
