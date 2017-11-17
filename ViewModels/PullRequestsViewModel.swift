//
//  PullRequestsViewModel.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class PullRequestsViewModel {
    var repo = [RepoObject]()
    
    func feedRequest(_ accessToken: String!, completionHandler:@escaping (_ succeed: Bool, _ total: Int?, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getRepos(accessToken!) { (repos, error) in
            if let fetchedRepos = repos {
                self.repo.append(contentsOf: fetchedRepos)
                completionHandler(true, fetchedRepos.count, nil)
            }
            else {
                completionHandler(false, nil, error)
            }
        }
    }
}
