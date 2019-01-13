//
//  APIContactList.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiContactListProtocol: class {
    
    func getContactList(page:Int, success: @escaping (Users)->Void,
                        error: @escaping ()->Void )
    
    var interactor: ApiContactListProtocol? {get set}

}

class APIContactList: ApiContactListProtocol {
    
    var interactor: ApiContactListProtocol?
    
    func getContactList(page: Int, success: @escaping (Users)->Void,
                        error: @escaping ()->Void ){
        
        let url = kApiURL + "?page=&results=" + String(page) + "&seed=abc"
        self.interactor = self
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default ).responseJSON {
            response in
            
            switch response.result {
            case .failure( _):
                    print("Result fail: \n \(String(describing: response.result.value ))\n\n\(response.response?.statusCode ?? -1)")
                
            case .success(_):
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    do {
                        var userModels = Users()
                        userModels = try decoder.decode(Users.self , from: data)
                        print("WheatherModel: \(userModels)")
                        
                        success(userModels)
                        
                    } catch let error {
                
                        print(error.localizedDescription)
                    }
            }
        }
    }
}
