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
    func feedRequest(completionHandler:@escaping (_ succeed: Bool, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getRepos() { (repos, error) in
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
