//
//  BranchObject.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class BranchObject {
    var name: String?
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let branchName = json["name"] {
            name = branchName as? String
        }
    }
}
