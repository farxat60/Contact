//
//  SaveUsersPresenter.swift
//  ContactList
//
//  Created by Joe Franc on 12/20/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class SaveUserPresenter: SaveUsersPresenterProtocol {
    
    var interactor: SaveUsersInputInteractorProtocol?
    var view: SaveUsersViewProtocol?
    var wireframe: SaveUsersWireFrameProtocol?

    func viewDidLoad() {
        interactor?.getSaveUser()
    }
    
    func showDetailSelectionFromSaveUsers(with user: UsersEntity, from view: UIViewController) {
        wireframe?.pushToDetailList(with: user, from: view)
    }
    
    func deleteItemInRealmObject(with index: Int) {
        self.interactor?.deleteRealmObject(id: index)
    }
}

extension SaveUserPresenter: SaveUsersOutputInteractorProtocol {
    
    func saveUsersDidFetch(userList: Array<UsersEntity>) {
        view?.showSaveUsers(with: userList)
    }
    
    
    
}
