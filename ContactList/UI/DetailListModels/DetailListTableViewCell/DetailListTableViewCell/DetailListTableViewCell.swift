//
//  DetailListTableViewCell.swift
//  ContactList
//
//  Created by Joe Franc on 12/12/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class DetailListTableViewCell: UITableViewCell, ReusableViewCell, UITextFieldDelegate {
    
    @IBOutlet var typeUser: UITextField!
    @IBOutlet var typeValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        typeUser.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        return true
    }
    
    
}
