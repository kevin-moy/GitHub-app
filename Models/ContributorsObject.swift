//
//  ContributorsObject.swift
//  Lua
//
//  Created by Kevin on 11/16/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class ContributorsObject {
    var amount: Int?
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let contributions = json["contributions"] {
            amount = contributions as? Int
        }
    }
}
