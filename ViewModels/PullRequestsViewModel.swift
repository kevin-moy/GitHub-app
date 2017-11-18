//
//  PullRequestsViewModel.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class PullRequestsViewModel {
    var prs = [PullRequestsObject]()
    
    func prRequest(_ url: URL!, completionHandler:@escaping (_ succeed: Bool, _ total: Int?, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getPullRequests(url!) { (prs, error) in
            if let fetchedPRs = prs {
                self.prs.append(contentsOf: fetchedPRs)
                completionHandler(true, fetchedPRs.count, nil)
            }
            else {
                completionHandler(false, nil, error)
            }
        }
    }
}
