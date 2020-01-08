//
//  Message.swift
//  InClass10
//
//  Created by Aaron Martin on 12/4/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import Foundation

class Message {
    var id:String?
    var autherID:String?
    var autherName:String?
    var message:String?
    init(messageID: String, autherID: String, autherName: String, message: String) {
        self.id = messageID
        self.autherID = autherID
        self.autherName = autherName
        self.message = message
    }
}
