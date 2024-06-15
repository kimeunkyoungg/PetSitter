//
//  HomeViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/11/24.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Post.postList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as!PostTableViewCell
        
        let target = Post.postList[indexPath.row]
        
        cell.postTitle.text=target.postTitle
        cell.postDetail.text=target.postDetail
        cell.price.text=target.price
        cell.userName.text=target.userName
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedPost = Post.postList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
           // 스토리보드에서 PostDetailViewController 인스턴스 생성
           if let postDetailVC = storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController {
               
               // 데이터를 PostDetailViewController에 전달
               postDetailVC.postTitle = selectedPost.postTitle
               postDetailVC.postDetail = selectedPost.postDetail
               postDetailVC.price = selectedPost.price
               postDetailVC.userName = selectedPost.userName
               
               // PostDetailViewController로 이동
               navigationController?.pushViewController(postDetailVC, animated: true)
           }
       }
       
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220 // 모든 셀의 높이를 100으로 설정
        
    }

    
    
    @IBAction func addPostButtonPressed(_ sender: UIButton) {
        if let addPostVC = storyboard?.instantiateViewController(withIdentifier: "AddPostViewController") {
            navigationController?.pushViewController(addPostVC, animated: true)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

}
