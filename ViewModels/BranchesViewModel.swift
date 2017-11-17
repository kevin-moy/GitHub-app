//
//  BranchesViewModel.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class BranchesViewModel {
    var branches = [BranchObject]()
    
    func branchRequest(_ url: URL!, completionHandler:@escaping (_ succeed: Bool, _ total: Int?, _ error: String?) -> Void) {
        ApiManager.sharedInstance.getBranches(url!) { (branches, error) in
            if let fetchedBranches = branches {
                self.branches.append(contentsOf: fetchedBranches)
                completionHandler(true, fetchedBranches.count, nil)
            }
            else {
                completionHandler(false, nil, error)
            }
        }
    }
}
