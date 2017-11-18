//
//  ViewController.swift
//  Lua
//
//  Created by Kevin on 11/16/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var repoFeed = RepoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepos()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func getRepos() {
        repoFeed.feedRequest() { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else if error != nil {
                self.noConnectionAlert()
            }
        }
    }
    
    func noConnectionAlert() {
        let alertController = UIAlertController.init(title: "Error", message: "No Internet connection. Please try again", preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepoCell
        cell.setupCell(repo: self.repoFeed.repo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoFeed.repo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = repoFeed.repo[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RepoVC") as! RepoViewController
        vc.repo = selectedRow
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

