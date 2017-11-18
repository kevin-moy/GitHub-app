//
//  IssuesViewModel.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class IssuesViewModel {
    var issues = [IssuesObject]()
    
    func issuesRequest(_ url: URL!, completionHandler:@escaping (_ succeed: Bool, _ total: Int?, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getIssues(url!) { (issues, error) in
            if let fetchedIssues = issues {
                self.issues.append(contentsOf: fetchedIssues)
                completionHandler(true, fetchedIssues.count, nil)
            }
            else {
                completionHandler(false, nil, error)
            }
        }
    }
}
