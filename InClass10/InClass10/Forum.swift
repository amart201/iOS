//
//  Forum.swift
//  InClass10
//
//  Created by Aaron Martin on 11/30/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import Foundation

class Forum {
    var id:String?
    var creatorName:String?
    var creatorID:String?
    var message:String?
    var likes:Int?
    
    init(id: String, name: String, creatorID: String, message: String, likes: Int) {
        self.id = id
        self.creatorName = name
        self.creatorID = creatorID
        self.message = message
        self.likes = likes
    }
}
