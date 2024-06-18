//
//  PostDetailViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/15/24.
//

import UIKit

//글 전체 화면
class PostDetailViewController: UIViewController {

    
    var post: Post?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var postDetailLabel: UILabel!
    
    @IBOutlet weak var doublePriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            userNameLabel.text = post.userName
            postTitleLabel.text = post.postTitle
            postDetailLabel.text = post.postDetail
            priceLabel.text = post.price
            
            if let priceValue = Double(post.price) {
                let doublePriceValue = priceValue * 2
                doublePriceLabel.text = "\(Int(doublePriceValue))"
            } else {
                doublePriceLabel.text = "N/A" // 혹시 오류날까봐
            }
        } else {
            userNameLabel.text = "N/A"
            postTitleLabel.text = "N/A"
            postDetailLabel.text = "N/A"
            priceLabel.text = "N/A"
            doublePriceLabel.text = "N/A"
        }
        
    }
    
    @IBAction func reservationButtonPressed(_ sender: UIButton) {
        guard let sitterID = post?.userID else { return }
        
        if let reservationVC = storyboard?.instantiateViewController(withIdentifier: "ReservationViewController") as? ReservationViewController {
            reservationVC.sitterID = sitterID
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
