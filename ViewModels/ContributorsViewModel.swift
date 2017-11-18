//
//  ContributorsViewModel.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class ContributorsViewModel {
    var contributors = [ContributorsObject]()
    var commits: Int = 0
    
    func contributorsRequest(_ url: URL!, completionHandler:@escaping (_ succeed: Bool, _ totalContributors: Int?, _ totalCommits: Int?, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getContributors(url!) { (contributors, totalCommits, error) in
            if let fetchedContributors = contributors {
                self.contributors.append(contentsOf: fetchedContributors)
                self.commits = totalCommits!
                
                completionHandler(true, fetchedContributors.count, totalCommits, nil)
            }
            else {
                completionHandler(false, nil, nil, error)
            }
        }
    }
}
