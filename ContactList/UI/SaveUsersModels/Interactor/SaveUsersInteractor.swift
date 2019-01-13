//
//  SaveUsersInteractor.swift
//  ContactList
//
//  Created by Joe Franc on 12/19/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import Foundation
import RealmSwift

class SaveUsersInteractor: SaveUsersInputInteractorProtocol {
    
    private var saveUsers: Array<UsersEntity> {
        return Array(try! Realm().objects(UsersEntity.self))
    }
    
    var presenter: SaveUsersOutputInteractorProtocol?

    
    public func deleteRealmObject(id: Int) {
        removeUser(at: id, user: saveUsers)
    }
    

    public func getSaveUser() {
        presenter?.saveUsersDidFetch(userList: saveUsers);
    }
    
    private func removeUser(at index: Int,user: Array<UsersEntity>) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(user[index])
        }
    }
    
}


