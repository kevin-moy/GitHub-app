//
//  IssuesObject.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class IssuesObject {
    var title: String!
    var number: Int!
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let issueNumber = json["number"] {
            number = issueNumber as? Int
        }
        
        if let issueTitle = json["title"] {
            title = issueTitle as? String
        }
    }
}
