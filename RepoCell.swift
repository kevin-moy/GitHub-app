//
//  RepoCell.swift
//  Lua
//
//  Created by Kevin on 11/16/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    func setupCell(repo: RepoObject) {
        name.text = repo.name
    }
}
