//
//  SignUpViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/11/24.
//
//회원가입 화면
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = nameTextField.text, !name.isEmpty else {
            return
        }
        
        // Firebase Authentication에 사용자 등록하기
        Auth.auth().createUser(withEmail: email, password: password) { authResult, _ in
            guard let user = authResult?.user else { return }
            let userID = user.uid
            
            // userInfo 데이터베이스에 사용자 정보 저장
            let db = Firestore.firestore()
            db.collection("userInfo").document(userID).setData([
                "name": name,
                "email": email
            ]) { _ in
                if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    let navController = UINavigationController(rootViewController: loginVC)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
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
