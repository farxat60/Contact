//
//  DetailListProtocols.swift
//  ContactList
//
//  Created by Joe Franc on 12/12/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

protocol DetailListViewProtocol: class {
    // PRESENTER -> VIEW
    func showDetailUsers(with user: Results)
}

protocol DetailListPresenterProtocol: class {
    //View -> Presenter
    var interactor: DetailListInputInteractorProtocol? {get set}
    var view: DetailListViewProtocol? {get set}
    var wireframe: DetailListWireFrameProtocol? {get set}
    var userEntity: UsersEntity? {get set}

    func viewDidLoad()
    func saveValue(tableView: UITableView, uiImage:UIImageView, userResult: Results)
    func pushToSaveUsersList(from view: UIViewController)
    
//    func returnUserEntity(result: Results)

}

protocol DetailListInputInteractorProtocol: class {
    //Presenter -> Interactor
    var presenter: DetailListOutputInteractorProtocol? {get set}
    func saveUser(tableView: UITableView, countCell: Int,uiImage: UIImageView, userResult: Results) 
    func sendUserEntity(userEntity: UsersEntity)

}

protocol DetailListOutputInteractorProtocol: class {
    func returnUserEntity(result: Results)
    //Interactor -> Presenter
}

protocol DetailListWireFrameProtocol: class {
    //Presenter -> Wireframe
    func goToSaveUsers(from view: UIViewController)
    func pushToDetailList(with user: Results,from view: UIViewController) 

}
