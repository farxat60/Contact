//
//  DetailListInteractor.swift
//  ContactList
//
//  Created by Joe Franc on 12/12/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit
import RealmSwift

class DetailListInteractor: DetailListInputInteractorProtocol {

   var presenter: DetailListOutputInteractorProtocol?
    
   public func sendUserEntity(userEntity: UsersEntity) {
        var userResults = Results()
        if let result = userEntity.results.first {
            userResults.email = result.email
            userResults.id = result.id
            var name = Name()
            name.title = result.name?.first
            name.first = result.name?.title
            name.last = result.name?.last
            userResults.name = name
            userResults.phone = result.phone
            var pictures = Picture()
            pictures.pictureImage = result.pictureImage
            userResults.picture = pictures
            userResults.typeValue = TypeValue.generateTypeList()
        }
        self.presenter?.returnUserEntity(result: userResults)
    }

    public func saveUser(tableView: UITableView, countCell: Int,uiImage: UIImageView, userResult: Results) {
            var arrayUser = [Any]()
                for i in 0...countCell {
                    let indexPath = IndexPath(row: i, section: 0)
                    let cell = tableView.cellForRow(at: indexPath) as? DetailListTableViewCell
                    if let value = cell?.typeUser.text {
                      arrayUser.append(value)
                    print("\(value)")
                    }
                }
                if let id = userResult.id {
                arrayUser.append(id)
                }
                arrayUser.append(returnImage(uiImage: uiImage))
                addInRealmModel(value: addStringToModel(userValue: arrayUser))
    }
    
    private func addInRealmModel(value: ModelUser) {
        let items = UsersEntity()
        print("\n\n \(value) \n\n")
    
        let item = ResultsEntity()
            item.email = value.email
            item.phone = value.phone
            if let value = value.id{
                item.id = value
            } else {
                item.id = incrementID()
            }
        
        if let uiimage = value.pictures {
            item.image = uiimage
        }
            let name = NameEntity()
            name.first = value.firstName
            name.last = value.lastName
            item.name = name
            items.results.append(item)
        
        let realm = try! Realm()
        try! realm.write {
            if item.id == incrementID(){
                realm.add(items)
            } else {
                realm.add(item, update: true)
            }
        }
    }
    
    private func addStringToModel(userValue: [Any]) -> ModelUser{
                var modelUserValue = ModelUser()
                for count in 0...userValue.count {
                    switch count {
                    case 0:
                        modelUserValue.firstName = userValue[0] as? String
                        break
                    case 1:
                        modelUserValue.lastName = userValue[1] as? String
                        break
                    case 2:
                        modelUserValue.email = userValue[2] as? String
                        break
                    case 3:
                        modelUserValue.phone = userValue[3] as? String
                        break
                    case 4:
                        modelUserValue.id = userValue[4] as? Int
                    default:
                        modelUserValue.pictures = userValue.last as? UIImage
                        break
                        }
                }
        return modelUserValue
    }
    
    private func returnImage(uiImage: UIImageView) -> UIImage{
        if let imageUser = uiImage.image {
            return imageUser
        }
        return UIImage(named: "no_image")!
    }
    
   private func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(ResultsEntity.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

