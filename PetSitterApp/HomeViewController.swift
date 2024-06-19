//
//  HomeViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/11/24.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//홈 화면
class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var db: Firestore!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as!PostTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.userName.text = post.userName
        cell.postTitle.text = post.postTitle
        cell.postDetail.text = post.postDetail
        cell.price.text = post.price
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        if selectedPost.userID == currentUser.uid {
            // 현재 사용자가 게시물 작성자인 경우 -> 수정화면으로
            if let editPostVC = storyboard?.instantiateViewController(withIdentifier: "EditPostViewController") as? EditPostViewController {
                editPostVC.post = selectedPost
                navigationController?.pushViewController(editPostVC, animated: true)
            }
        } else {
            // 게시물 작성자가 아닌 경우 PostDetailViewController로 이동
            if let postDetailVC = storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController {
                postDetailVC.post = selectedPost
                navigationController?.pushViewController(postDetailVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    @IBAction func addPostButtonPressed(_ sender: UIButton) {
        if let addPostVC = storyboard?.instantiateViewController(withIdentifier: "AddPostViewController") {
            navigationController?.pushViewController(addPostVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        fetchPosts()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // firebase로부터 가져온 데이터를 post로
    func fetchPosts() {
        db.collection("post").getDocuments { (querySnapshot, error) in
            if let error = error {
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            

            self.posts = documents.map { document -> Post in
                let data = document.data()
                let postID = document.documentID
                let userID = data["userID"] as? String ?? ""
                let userName = data["userName"] as? String ?? ""
                let postTitle = data["title"] as? String ?? ""
                let postDetail = data["detail"] as? String ?? ""
                let price = data["price"] as? String ?? ""
                
                return Post(postID: postID, userID: userID, userName: userName, postTitle: postTitle, postDetail: postDetail, price: price)
            }
            
            self.tableView.reloadData()
        }
    }
    
    // PostDetailViewController로 데이터를 전달할 때 사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postDetailVC = segue.destination as? PostDetailViewController, let selectedPost = sender as? Post {
            postDetailVC.post = selectedPost
        } else if let reservationVC = segue.destination as? ReservationViewController, let sitterID = sender as? String {
            reservationVC.sitterID = sitterID
        }
        
    }
       
    func navigateToReservationViewController(with sitterID: String) {
        if let reservationVC = storyboard?.instantiateViewController(withIdentifier: "ReservationViewController") as? ReservationViewController {
            reservationVC.sitterID = sitterID
            navigationController?.pushViewController(reservationVC, animated: true)
        }
        
    }
    
    
}
