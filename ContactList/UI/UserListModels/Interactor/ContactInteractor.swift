//
//  UsersInteractor.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import Foundation

class ContactInteractor: ListInputInteractorProtocol {
 
    weak var presenter: ListOutputInteractorProtocol?
    let values: ApiContactListProtocol = APIContactList()

    func getUserListList(page: Int) {
        getUsers(page: page)
    }
    
    func getUsers(page: Int) {
        var user = Users()
        values.getContactList(page: page, success: { [weak self] item in
            print("ITEM: \(item)")
            user = item
            self?.presenter?.userListDidFetch(userList: user)
            
            }, error: {
                print("ERROR response")
        })
    }
    
}
