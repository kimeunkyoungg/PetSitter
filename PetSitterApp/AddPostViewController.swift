//
//  AddPostViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/15/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//글 추가 화면
class AddPostViewController: UIViewController {

    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        


    }
    
    @IBAction func finishAddPostButtonPressed(_ sender: UIButton) {
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid
        let title = titleTextField.text ?? ""
        let price = priceTextField.text ?? ""
        let detail = detailTextField.text ?? ""
        
        // userInfo에서 이름 가져오기
        db.collection("userInfo").document(userID).getDocument { [weak self] (document, error) in
            
            guard let document = document, document.exists, let data = document.data() else {
                return
            }
            
            let userName = data["name"] as? String ?? "Unknown"
            
            let postData: [String: Any] = [
                "userID": userID,
                "userName": userName,
                "title": title,
                "price": price,
                "detail": detail
            ]
            
            self?.db.collection("post").addDocument(data: postData) { error in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                } else {

                    DispatchQueue.main.async {
                        if let tabBarVC = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                            self?.navigationController?.setViewControllers([tabBarVC], animated: true)
                        }
                    }
                }
            }
        }
        
    }
    

}
