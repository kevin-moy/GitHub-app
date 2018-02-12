//
//  ApiManager.swift
//  Lua
//
//  Created by Kevin on 11/16/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let sharedInstance = ApiManager()
    
    func getRepos(completionHandler:@escaping (_ repos: [RepoObject]?, _ error: String?) -> Void) {
        
        var repoArray = [RepoObject]()
        let url = URL(string: Github.publicRepos)!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print(error!)
                completionHandler(nil, error as! String?)
                return
            }
            guard data != nil else {
                print("Data is empty")
                return
            }
            
            if error != nil {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                guard let repoJSON = json as? [[String: Any]] else {
                    completionHandler(nil, "JSON not a dictionary")
                    return }
                
                for feedData in repoJSON {
                    let feed = RepoObject.init(json: feedData)
                    repoArray.append(feed)
                }
                completionHandler(repoArray, nil)
            }
        })
        task.resume()
            completionHandler(repoArray, nil)
    }
    
    func getBranches(_ branchURL: URL!, completionHandler:@escaping (_ branches: [BranchObject]?, _ error: String?) -> Void) {
        
        let group = DispatchGroup()
        var branchesArray = [BranchObject]()
    
        group.enter()
        let task = URLSession.shared.dataTask(with: branchURL!, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print(error!)
                completionHandler(nil, error as! String?)
                return
            }
            guard data != nil else {
                print("Data is empty")
                return
            }
            
            if error != nil {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                guard let branchJSON = json as? [[String: Any]] else {
                    completionHandler(nil, "JSON not a dictionary")
                    return }
                
                for branchData in branchJSON {
                    let feed = BranchObject.init(json: branchData)
                    branchesArray.append(feed)
                }
                completionHandler(branchesArray, nil)
            }
        })
        task.resume()
        group.notify(queue: .main) {
            completionHandler(branchesArray, nil)
        }
    }
    
    func getContributors(_ contributorsURL: URL!, completionHandler:@escaping (_ contributors: [ContributorsObject]?, _ commits: Int?, _ error: String?) -> Void) {
        
        let group = DispatchGroup()
        var contributorsArray = [ContributorsObject]()
        var commits: Int = 0
        
        group.enter()
        let task = URLSession.shared.dataTask(with: contributorsURL!, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print(error!)
                completionHandler(nil, nil, error as! String?)
                return
            }
            guard data != nil else {
                print("Data is empty")
                return
            }
            
            if error != nil {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                guard let contributorsJSON = json as? [[String: Any]] else {
                    completionHandler(nil, nil, "JSON not a dictionary")
                    return }
                
                for contributorsData in contributorsJSON {
                    let feed = ContributorsObject.init(json: contributorsData)
                    commits = commits + feed.amount!
                    contributorsArray.append(feed)
                }
                completionHandler(contributorsArray, commits, nil)
            }
        })
        task.resume()
        group.notify(queue: .main) {
            completionHandler(contributorsArray, nil, nil)
        }
    }
    
    func getPullRequests(_ pullRequestURL: URL!, completionHandler:@escaping (_ pullRequests: [PullRequestsObject]?, _ error: String?) -> Void) {
        
        let group = DispatchGroup()
        var pullRequestsArray = [PullRequestsObject]()
        
        group.enter()
        let task = URLSession.shared.dataTask(with: pullRequestURL!, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print(error!)
                completionHandler(nil, error as! String?)
                return
            }
            guard data != nil else {
                print("Data is empty")
                return
            }
            
            if error != nil {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                guard let pullRequestsJSON = json as? [[String: Any]] else {
                    completionHandler(nil, "JSON not a dictionary")
                    return }
                
                for pullRequestsData in pullRequestsJSON {
                    let feed = PullRequestsObject.init(json: pullRequestsData)
                    pullRequestsArray.append(feed)
                }
                completionHandler(pullRequestsArray, nil)
            }
        })
        task.resume()
        group.notify(queue: .main) {
            completionHandler(pullRequestsArray, nil)
        }
    }
    
    func getIssues(_ issuesURL: URL!, completionHandler:@escaping (_ issues: [IssuesObject]?, _ error: String?) -> Void) {
        
        let group = DispatchGroup()
        var issuesArray = [IssuesObject]()
        
        group.enter()
        let task = URLSession.shared.dataTask(with: issuesURL!, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print(error!)
                completionHandler(nil, error as! String?)
                return
            }
            guard data != nil else {
                print("Data is empty")
                return
            }
            
            if error != nil {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                guard let issuesJSON = json as? [[String: Any]] else {
                    completionHandler(nil, "JSON not a dictionary")
                    return }
                
                for issuesData in issuesJSON {
                    let feed = IssuesObject.init(json: issuesData)
                    issuesArray.append(feed)
                }
                completionHandler(issuesArray, nil)
            }
        })
        task.resume()
        group.notify(queue: .main) {
            completionHandler(issuesArray, nil)
        }
    }
    
    
    func createIssue(_ issueURL: URL!, _ issueTitle: String!, issueBody: String!, completionHandler:@escaping (_ succeed: Bool, _ error: String?) -> Void) {
        
        var statusCode: Int! = 0
        let group = DispatchGroup()
        let defaults = UserDefaults.standard
        let url = issueURL!
        var request = URLRequest(url: url)

        if defaults.string(forKey: defaultKeys.accessCode) != nil {
            request.setValue("token \(defaults.string(forKey: defaultKeys.accessCode)!)", forHTTPHeaderField: "Authorization")
        }
       
        let json: [String: Any] = ["title": issueTitle,
                                   "body": issueBody]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        group.enter()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                completionHandler(false, String(describing: error))
                return
            }
            if let httpStatus = response as? HTTPURLResponse {
                statusCode = httpStatus.statusCode
            }
            
            completionHandler(true, String(statusCode))
        }
        task.resume()
        group.notify(queue: .main) {
                completionHandler(true, String(statusCode))
        }
    }
    func getAccessToken(_ code: String!, completionHandler:@escaping (_ succeed: Bool, _ code: String, _ error: String?) -> Void) {
        
        let url = URL(string:"https://github.com/login/oauth/access_token")
        var request = URLRequest(url: url!)
        var accessCode: String = ""
        let group = DispatchGroup()
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "client_id=\(Github.clientID)&client_secret=\(Github.clientSecret)&code=\(code!)"
        request.httpBody = postString.data(using: .utf8)
        group.enter()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(false, "None", String(describing: error))
                return
            }
            let responseString = String(data: data, encoding: .utf8)
        
            if let upperRange = responseString?.range(of: "access_token=") {
                let upperString = String(describing: responseString!.suffix(from: upperRange.upperBound))
                if let lowerRange = upperString.range(of: "&scope") {
                    accessCode = String(upperString[upperString.startIndex..<lowerRange.lowerBound])
                    completionHandler(true, accessCode, nil)
                }
            }
        }
        task.resume()
        group.notify(queue: .main) {
            completionHandler(true, accessCode, nil)
        }
    }

}
