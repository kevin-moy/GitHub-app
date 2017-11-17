//
//  RepoObject.swift
//  Lua
//
//  Created by Kevin on 11/16/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class RepoObject {
    var name: String!
    var info: String!
    var issueURL: URL!
    var branchesURL: URL!
    var pullsURL: URL!
    var contributorsURL: URL!
    //name
    //description: TItle
    //issue_events_url
    //branches_url -> get number of branches
    //issues_url -> list of issues, number by count
    //pulls_url -> get count, view list of PRs
    //contributors_url -> get count contributors, then add up contributions for number of commits
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let repoName = json["name"] {
            name = repoName as? String
        }
        
        if let repoInfo = json["description"] {
            info = repoInfo as? String
        }
        
        if let issue = json["issues_url"] {
            let issueString = issue as! String
            if let range = issueString.range(of: "{") {
                let urlString = String(issueString[issueString.startIndex..<range.lowerBound])
                issueURL = URL(string: urlString)
            }
        }
        
        if let branches = json["branches_url"] {
            let branchesString = branches as! String
            if let range = branchesString.range(of: "{") {
                let urlString = String(branchesString[branchesString.startIndex..<range.lowerBound])
                branchesURL = URL(string: urlString)
            }
        }
        
        if let pulls = json["pulls_url"] {
            let pullsString = pulls as! String
            if let range = pullsString.range(of: "{") {
                let urlString = String(pullsString[pullsString.startIndex..<range.lowerBound])
                pullsURL = URL(string: urlString)
            }
        }
        
        if let contributors = json["contributors_url"] {
            let contributorsString = contributors as! String
            contributorsURL = URL(string: contributorsString)
        }
    }
    
}
