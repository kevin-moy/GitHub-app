//
//  AddIssueViewController.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class AddIssueViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var issueTitle: String! = ""
    var issueBody: String! = ""
    var issueURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.layer.borderWidth = 1
        bodyTextView.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if issueTitle == "" {
            let alertController = UIAlertController.init(title: "Error", message: "Need an issue title", preferredStyle: .alert)
            let okayAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        ApiManager.sharedInstance.createIssue(issueURL, issueTitle, issueBody: issueBody) { (success, error) in
            if success {
                print("succesful issue")
            }
        }
       print(issueTitle)
        print(issueBody)
    }
    
    // MARK: Textview delegate
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView == titleTextView {
            issueTitle = textView.text
        }
        if textView == bodyTextView {
            issueBody = textView.text
        }
        textView.resignFirstResponder()
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
