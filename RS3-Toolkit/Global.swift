//
//  Global.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 2/26/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation

struct Global {
    static var username: String = "ChadTek"
    static var activities: Int = 20
    static var mainUserData: UserData = UserData()
    static var updateInProgress: Bool = false {
        didSet {
            if updateInProgress {
                print("--Loading Data--")
            } else {
                print("--Finished Loading Data--")
            }
        }
    }
}
