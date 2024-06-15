//
//  Post.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import Foundation
import UIKit

class Post {
    var userName : String
    var postTitle : String
    var postDetail : String
    var price : String
    
    init(userName: String, postTitle: String, postDetail: String, price: String) {
        self.userName = userName
        self.postTitle = postTitle
        self.postDetail = postDetail
        self.price = price
    }
    
    static var postList : [Post]=[Post(userName: "믄경", postTitle: "고양이 돌봐드려요", postDetail: "3년차 집사입니다. 믿고 맏겨주세요.", price: "10000"), Post(userName: "웅갱", postTitle: "강아지 돌봐드려요", postDetail: "4년차 집사입니다. 최선을 다해 돌봐드립니다. 맡겨주세요", price: "25000"),Post(userName: "태태", postTitle: "강아지, 고양이 돌봐드려요", postDetail: "n년차 집사입니다. 최선을 다해 돌봐드립니다. 누구보다 잘 돌봐드릴수있어요", price: "15000")]
}
