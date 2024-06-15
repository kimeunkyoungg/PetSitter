//
//  PostDetailViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/15/24.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var userName : String?
    var postTitle : String?
    var postDetail : String?
    var price : String?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var postDetailLabel: UILabel!
    
    @IBOutlet weak var doublePriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTitleLabel.text = postTitle
        postDetailLabel.text = postDetail
        priceLabel.text = price
        userNameLabel.text = userName
        
        if let price = price {
            if let priceValue = Double(price) {
                let doublePriceValue = priceValue * 2
                doublePriceLabel.text = "\(Int(doublePriceValue))"
                
            } 
            else {
                doublePriceLabel.text = "N/A" // price가 유효하지 않은 경우
                        
                        }
        } else {
            doublePriceLabel.text = "N/A" // price가 nil인 경우
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reservationButtonPressed(_ sender: UIButton) {
        if let reservationVC = storyboard?.instantiateViewController(withIdentifier: "ReservationViewController") {
            navigationController?.pushViewController(reservationVC, animated: true)
            
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
