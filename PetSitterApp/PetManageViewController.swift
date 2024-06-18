//
//  PetManageViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/13/24.
//
// 셀 간격 수정
//나의 반려동물 화면
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PetManageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let dbFirebase = DbFirebase()

     override func viewDidLoad() {
         super.viewDidLoad()
         tableView.delegate = self
         tableView.dataSource = self
         
         fetchPetData()
     }
     
     func fetchPetData() {
         guard let user = Auth.auth().currentUser else {
             return
         }
         
         let userID = user.uid
         let db = Firestore.firestore()
         
         db.collection("petInfo").whereField("userID", isEqualTo: userID).getDocuments { (snapshot, _) in
             guard let documents = snapshot?.documents else { return }
             
             MyPet.myPetList.removeAll()
             
             for document in documents {
                 let data = document.data()
                 let petName = data["name"] as? String ?? ""
                 let petImageURL = data["imageUrl"] as? String
                 let petAge = data["age"] as? String ?? ""
                 let petKind = data["kind"] as? String ?? ""
                 let petSex = data["sex"] as? String ?? ""
                 let petWeight = data["weight"] as? String ?? ""
                 let pet = MyPet(petName: petName, petImageURL: petImageURL, age: petAge, kind: petKind, sex: petSex, weight: petWeight)
                 MyPet.myPetList.append(pet)
                 
             }
             
             self.loadPetImages()
             
         }
     }
     
    func loadPetImages() {
        let dispatchGroup = DispatchGroup()
        
        for pet in MyPet.myPetList {
            guard let imageUrlString = pet.petImageURL, let imageUrl = URL(string: imageUrlString) else {
                continue
            }
            
            dispatchGroup.enter()
            URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                if let data = data {
                    pet.petImage = UIImage(data: data)
                }
                dispatchGroup.leave()
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
    }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return MyPet.myPetList.count
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPetCell", for: indexPath) as! MyPetTableViewCell
        
        let target = MyPet.myPetList[indexPath.row]
        
        cell.petName.text = target.petName
        if let petImage = target.petImage {
            cell.petImage.image = petImage
        } else {
            cell.petImage.image = UIImage(named: "defaultPetImage")
            
        }
        
        
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPet = MyPet.myPetList[indexPath.row]
        
        if let petDetailVC = storyboard?.instantiateViewController(withIdentifier: "PetDetailViewController") as? PetDetailViewController {
            petDetailVC.pet = selectedPet
            navigationController?.pushViewController(petDetailVC, animated: true)
        }
        
    }
    
    
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 130
     }

     @IBAction func addPetButtonPressed(_ sender: UIButton) {
         if let addPetVc = storyboard?.instantiateViewController(withIdentifier: "AddPetViewController") {
             navigationController?.pushViewController(addPetVc, animated: true)
         }
     }
 }
