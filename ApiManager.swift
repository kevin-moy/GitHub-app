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
    
    func getRepos(_ accessToken: String!, completionHandler:@escaping (_ repos: [RepoObject]?, _ error: String?) -> Void) {
        
        let group = DispatchGroup()
        var repoArray = [RepoObject]()
        let url = URL(string: "https://api.github.com/repositories?since=41")!
        
        group.enter()
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
                print("Error fetching photos: \(String(describing: error))")
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
        group.notify(queue: .main) {
            completionHandler(repoArray, nil)
        }
    }
    
    func getBranches(_ branchURL: URL!, completionHandler:@escaping (_ branchCount: [BranchObject]?, _ error: String?) -> Void) {
        
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
                print("Error fetching photos: \(String(describing: error))")
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
    
    func getContributors(_ contributorsURL: URL!, completionHandler:@escaping (_ branchCount: [ContributorsObject]?, _ error: String?) -> Void) {
        
        let group = DispatchGroup()
        var contributorsArray = [ContributorsObject]()
        
        group.enter()
        let task = URLSession.shared.dataTask(with: contributorsURL!, completionHandler: {data, response, error -> Void in
            
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
                print("Error fetching photos: \(String(describing: error))")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                guard let contributorsJSON = json as? [[String: Any]] else {
                    completionHandler(nil, "JSON not a dictionary")
                    return }
                
                for contributorsData in contributorsJSON {
                    let feed = ContributorsObject.init(json: contributorsData)
                    contributorsArray.append(feed)
                }
                completionHandler(contributorsArray, nil)
            }
        })
        task.resume()
        group.notify(queue: .main) {
            completionHandler(contributorsArray, nil)
        }
    }
}
