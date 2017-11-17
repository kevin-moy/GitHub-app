//
//  RepoViewModel.swift
//  Lua
//
//  Created by Kevin on 11/16/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class RepoViewModel {
    var repo = [RepoObject]()
    // KEVIN CHANGE ACCESSTOKEN
    func feedRequest(_ accessToken: String!, completionHandler:@escaping (_ succeed: Bool, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getRepos(accessToken!) { (repos, error) in
            if let fetchedRepos = repos {
                self.repo.append(contentsOf: fetchedRepos)
                completionHandler(true, nil)
            }
            else {
                completionHandler(false, error)
            }
        }
    }
}
