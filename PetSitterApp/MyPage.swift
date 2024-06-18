//
//  MyPage.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/13/24.
//

import Foundation
import UIKit

class MyPage {
    var title: String
       var content: String
       var image: UIImage? // UIImage 속성 추가

       init(title: String, content: String, image: UIImage?) {
           self.title = title
           self.content = content
           self.image = image
       }

       static var myPageList: [MyPage] = [
           MyPage(title: "내 반려동물", content: "내 반려동물을 등록하고 관리하세요", image: UIImage(named: "dog")),
           MyPage(title: "예약 내역", content: "나의 예약내역을 확인해보세요", image: UIImage(named: "reservation")),
           MyPage(title: "돌봄 내역", content: "나의 돌봄내역을 확인해보세요", image: UIImage(named: "walk"))
       ]
}
