//
//  RepoViewController.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commitsLabel: UILabel!
    @IBOutlet weak var branchesLabel: UILabel!
    @IBOutlet weak var contributorsLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    
    
    var repo: RepoObject!
    var branchFeed = BranchesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = repo.name
        descriptionLabel.text = repo.info
        getBranches()
        getIssues()
        getPullRequests()
        getContributors()

    }
    
    @IBAction func issuesButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func pullRequestsButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func addIssueButtonPressed(_ sender: UIButton) {
    }
    
    
    func getBranches() {
        branchFeed.branchRequest(repo.branchesURL) { (success, total, error) in
            if success {
                DispatchQueue.main.async {
                    self.branchesLabel.text = "Branches: \(total!)"
            }
        }
        }
    }
    
    func getIssues() {
        
    }
    
    func getPullRequests() {
        
    }
    
    func getContributors() {
        
    }
}
