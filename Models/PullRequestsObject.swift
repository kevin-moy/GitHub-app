//
//  PullRequestsObject.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class PullRequestsObject {
    var title: String!
    var number: Int!
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let prNumber = json["number"] {
            number = prNumber as? Int
        }
        
        if let prTitle = json["title"] {
            title = prTitle as? String
        }
    }
}
