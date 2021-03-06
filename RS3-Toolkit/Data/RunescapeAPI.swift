//
//  RunescapeAPI.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation

enum Method: String {
    case hiscore = "https://services.runescape.com/m=hiscore/index_lite.ws"
    case runemetrics = "https://apps.runescape.com/runemetrics/profile/profile"
    case avatar = "https://secure.runescape.com/m=avatar-rs/"
}

struct RunescapeAPI {
    
    private static func runescapeURL(method: Method, parameters: [String:String]?) -> URL {
        var urlString = method.rawValue
        
        if parameters != nil {
            switch method {
            case .hiscore:
                urlString += "?player=" + parameters!["username"]!
            case .runemetrics:
                urlString += "?user=" + parameters!["username"]!
                urlString += "&activities=" + parameters!["activities"]!
            case .avatar:
                urlString += parameters!["username"]! + "/chat.png"
            }
        }
        
        print("Created URL: \(urlString)")
        let url = URL(string: urlString)
        return url!
    }
    
    static var hiscoreURL: URL {
        return runescapeURL(method: .hiscore, parameters: ["username" : Global.username])
    }
    
    static var runemetricsURL: URL {
        return runescapeURL(method: .runemetrics, parameters: ["username" : Global.username, "activities" : String(Global.activities)])
    }
    
    static var avatarURL: URL {
        return runescapeURL(method: .avatar, parameters: ["username" : Global.username])
    }
    
}
