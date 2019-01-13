//
//  PhotoDetailTableViewCell.swift
//  ContactList
//
//  Created by Joe Franc on 12/14/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class PhotoDetailTableViewCell: UITableViewCell, ReusableViewCell {
    
    @IBOutlet var photoImage: UIImageView!
    var imagePhoto: UIImage!
    @IBOutlet var changePhoto: UIButton!
    
    var delegate : ImagePickerDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderInCell(uiImage: photoImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func pickImage(_ sender: Any) {
        delegate?.pickImage()

    }
}
