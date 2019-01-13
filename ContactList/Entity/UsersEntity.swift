//
//  UsersEntity.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit
import RealmSwift

class UsersEntity: Object {
    let results = List<ResultsEntity>()
}

class ResultsEntity: Object {
    @objc dynamic var name: NameEntity?
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var picture: PictureEntity?
    @objc dynamic var pictureImage: NSData? = nil
    @objc dynamic var id : Int = 0
    
    @objc dynamic var image : UIImage? {
        get {
            if let data = self.pictureImage {
                return UIImage(data: data as Data)
            } else {
                return nil
            }
        }
        set {
            if let image = newValue {
                self.pictureImage = image.pngData() as NSData?
            } else {
                self.pictureImage = nil
            }
        }
    }
    override static func primaryKey() -> String? {
        return "id"
    }

}

class NameEntity: Object {
    @objc dynamic var title: String?
    @objc dynamic var first: String?
    @objc dynamic var last: String?
    
}

class PictureEntity: Object {
    @objc dynamic var large: String?
    @objc dynamic var medium: String?
    @objc dynamic var thumbnail: String?
}



