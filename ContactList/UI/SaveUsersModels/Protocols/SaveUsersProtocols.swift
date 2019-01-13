//
//  SaveUsersProtocols.swift
//  ContactList
//
//  Created by Joe Franc on 12/19/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

protocol SaveUsersViewProtocol: class {
    // PRESENTER -> VIEW
    func showSaveUsers(with user: Array<UsersEntity>)
    
}

protocol SaveUsersPresenterProtocol: class {
    //View -> Presenter

    var interactor: SaveUsersInputInteractorProtocol? {get set}
    var view: SaveUsersViewProtocol? {get set}
    var wireframe: SaveUsersWireFrameProtocol? {get set}
    
    func showDetailSelectionFromSaveUsers(with user: UsersEntity, from view: UIViewController)
    func deleteItemInRealmObject(with index: Int)
    func viewDidLoad()
}

protocol SaveUsersInputInteractorProtocol: class {
    //Presenter -> Interactor
    func getSaveUser()
    var presenter: SaveUsersOutputInteractorProtocol? {get set}
    func deleteRealmObject(id: Int)
}

protocol SaveUsersOutputInteractorProtocol: class {
    func saveUsersDidFetch(userList: Array<UsersEntity>)
    //Interactor -> Presenter
}

protocol SaveUsersWireFrameProtocol: class {
    //Presenter -> Wireframe
    
    func pushToSaveUsers(from view: UIViewController)
    static func createSaveUsersModule(saveUsers: SaveUsersViewController)
    func pushToDetailList(with user: UsersEntity,from view: UIViewController)

}

