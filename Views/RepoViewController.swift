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
    @IBOutlet weak var prLabel: UILabel!
    
    var repo: RepoObject!
    var branchFeed = BranchesViewModel()
    var contributorsFeed = ContributorsViewModel()
    var prFeed = PullRequestsViewModel()
    var issuesFeed = IssuesViewModel()
    
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "IssuesVC") as! IssueViewController
        vc.issuesFeed = issuesFeed
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pullRequestsButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "prVC") as! PRViewController
        vc.prFeed = prFeed
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addIssueButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddIssueVC") as! AddIssueViewController
        vc.issueURL = repo.issueURL
        self.navigationController?.pushViewController(vc, animated: true)
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
        issuesFeed.issuesRequest(repo.issueURL) { (success, total, error) in
            if success {
                DispatchQueue.main.async {
                    self.issuesLabel.text = "Issues: \(total!)"
                }
            }
        }
    }
    
    func getPullRequests() {
        prFeed.prRequest(repo.pullsURL) { (success, total, error) in
            if success {
                DispatchQueue.main.async {
                    self.prLabel.text = "Pull Requests: \(total!)"
                }
            }
        }
    }
    
    func getContributors() {
        contributorsFeed.contributorsRequest(repo.contributorsURL) { (success, contributors, commits, error) in
            if success {
                DispatchQueue.main.async {
                    self.commitsLabel.text = "Commits: \(commits!)"
                    self.contributorsLabel.text =  "Contributors: \(contributors!)"
                }
            }
        }
    }
}
