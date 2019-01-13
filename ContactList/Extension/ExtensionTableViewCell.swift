//
//  ExtensionTableViewCell.swift
//  ContactList
//
//  Created by Joe Franc on 10/24/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

protocol ReusableViewCell: class { }

extension ReusableViewCell where Self: UIView {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
}

extension UITableViewCell {
    func borderInCell(uiImage: UIImageView) {
        uiImage.layer.cornerRadius = uiImage.frame.size.height / 2
        uiImage.layer.masksToBounds = true
        uiImage.clipsToBounds = true
        uiImage.contentMode = .scaleAspectFit
        uiImage.backgroundColor = UIColor.lightGray
    }
}
