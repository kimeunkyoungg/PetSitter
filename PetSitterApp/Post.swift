//
//  Post.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import Foundation
import UIKit

class Post {
    var postID : String
    var userID: String
    var userName : String
    var postTitle : String
    var postDetail : String
    var price : String
    
    init(postID : String, userID : String, userName: String, postTitle: String, postDetail: String, price: String) {
        self.postID = postID
        self.userID = userID
        self.userName = userName
        self.postTitle = postTitle
        self.postDetail = postDetail
        self.price = price
    }
    
    static var postList: [Post]=[]
}
