//
//  UsersProtocol.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

protocol ContactListViewProtocol: class {
    // PRESENTER -> VIEW
    func showUsers(with users: Users)
    

}

protocol ListPresenterProtocol: class {
    //View -> Presenter
    var interactor: ListInputInteractorProtocol? {get set}
    var view: ContactListViewProtocol? {get set}
    var wireframe: ListWireFrameProtocol? {get set}
    var api: ApiContactListProtocol? {get set}
    
    func viewDidLoad()
    func showDetailSelection(with user: Results, from view: UIViewController)
}

protocol ListInputInteractorProtocol: class {
    var presenter: ListOutputInteractorProtocol? {get set}
    func getUserListList(page: Int)
    //Presenter -> Interactor
}

protocol ListOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func userListDidFetch(userList: Users)
}

protocol ListWireFrameProtocol: class {
    //Presenter -> Wireframe
    func pushToDetailList(with user: Results,from view: UIViewController)
    static func createUserListModule(userListRef: ContactListViewController)
}
