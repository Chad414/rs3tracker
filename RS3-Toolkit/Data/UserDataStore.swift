//
//  UserDataStore.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation

enum UserDataResult {
    case success(UserData)
    case failure(Error)
}

class UserDataStore {
    
    func fetchUserData(completion: @escaping (UserDataResult) -> Void) {
        let url: URL = RunescapeAPI.runemetricsURL
        Global.updateInProgress = true
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if let error = error {
                print("URLSession Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No Data Recieved")
                return
            }
            
            let result: UserDataResult
            
            // Serialize JSON Here
            do {
                let userData = try JSONDecoder().decode(UserData.self, from: data)
                print("Fetched User: \(userData.name), Total Level: \(userData.totalskill)")
                result = UserDataResult.success(userData)
            } catch let error {
                print("Error Serializing JSON: \(error)")
                result = UserDataResult.failure(error)
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }.resume()
    }
    
}
