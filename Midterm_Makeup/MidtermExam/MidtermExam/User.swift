//
//  User.swift
//  MidtermExam
//
//  Created by Aaron Martin on 11/23/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import Foundation

class User {
    var token:String?
    var email:String?
    var firstName:String?
    var lastName:String?
    var id:String?
    init(token: String, email: String, firstName: String, lastName: String, id: String) {
        self.token = token
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
}
