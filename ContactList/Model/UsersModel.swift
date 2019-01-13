//
//  UsersModel.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

struct Users: Decodable {
    var results: [Results]!
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Results: Decodable {
    var name: Name?
    var email: String?
    var phone: String?
    var picture: Picture?
    var typeValue = [String]()
    var id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case email
        case phone
        case picture
    }
    
}

struct Name: Decodable {
    var title: String?
    var first: String?
    var last: String?
    var fullName: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case first
        case last
    }
}

struct Picture: Decodable {
    var large: String?
    var medium: String?
    var thumbnail: String?
    var pictureImage: NSData?
    
    private enum CodingKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }
}

