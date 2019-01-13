//
//  ContactPresenter.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class ContactPresenter: ListPresenterProtocol {

    var wireframe: ListWireFrameProtocol?
    var view: ContactListViewProtocol?
    var interactor: ListInputInteractorProtocol?
    var presenter: ListPresenterProtocol?
    var api: ApiContactListProtocol?
    
    func viewDidLoad() {
        self.loadUserList()
    }
    
    func loadUserList() {
        interactor?.getUserListList(page: 0)
    }
    
    func showDetailSelection(with user: Results, from view: UIViewController) {
        wireframe?.pushToDetailList(with: user, from: view)
    }
    
}

extension ContactPresenter: ListOutputInteractorProtocol {

    func userListDidFetch(userList: Users) {
        view?.showUsers(with: userList)
    }
    
}


