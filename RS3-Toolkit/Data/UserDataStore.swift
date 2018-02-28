//
//  UserDataStore.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation
import UIKit

enum UserDataResult {
    case success(UserData)
    case failure(Error)
}

enum UserAvatarResult {
    case success(UIImage)
    case failure(Error?)
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
                print("Total Skills: \(userData.skillvalues.count)")
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
    
    func fetchUserAvatar(completion: @escaping (UserAvatarResult) -> Void) {
        let url: URL = RunescapeAPI.avatarURL
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
            let result: UserAvatarResult
            
            let imageData = data
            if let image = UIImage(data: imageData) {
                result = .success(image)
                print("Avatar successfully created!")
            } else {
                result = .failure(nil)
                print("Failed to create avatar image from data")
            }
            OperationQueue.main.addOperation {
                completion(result)
            }
        }.resume()
    }
    
}
