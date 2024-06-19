//
//  EditPostViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/15/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//글 수정 화면
class EditPostViewController: UIViewController {

    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    var post: Post!
    var db: Firestore!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        db = Firestore.firestore()

        titleTextField.text = post.postTitle
        priceTextField.text = post.price
        detailTextField.text = post.postDetail
        // Do any additional setup after loading the view.
    }
    

    @IBAction func editFinishedButtonPressed(_ sender: UIButton) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let updatedData: [String: Any] = [
            "title": titleTextField.text ?? "",
            "price": priceTextField.text ?? "",
            "detail": detailTextField.text ?? ""
        ]
        
        db.collection("post").document(post.postID).updateData(updatedData) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else {

                if let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                    self.navigationController?.setViewControllers([tabBarVC], animated: true)
                }
            }
            
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
extension EditPostViewController{
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        detailTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        titleTextField.resignFirstResponder()
   
    }
    
}
