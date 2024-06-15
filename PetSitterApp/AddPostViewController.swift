//
//  AddPostViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/15/24.
//

import UIKit

class AddPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") {
            navigationController?.pushViewController(signUpVC, animated: true)
            
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
