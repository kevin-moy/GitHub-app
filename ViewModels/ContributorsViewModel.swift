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
    
    func contributorsRequest(_ url: URL!, completionHandler:@escaping (_ succeed: Bool, _ total: Int?, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getContributors(url!) { (contributors, error) in
            if let fetchedContributors = contributors {
                self.contributors.append(contentsOf: fetchedContributors)
                completionHandler(true, fetchedContributors.count, nil)
            }
            else {
                completionHandler(false, nil, error)
            }
        }
    }
}
