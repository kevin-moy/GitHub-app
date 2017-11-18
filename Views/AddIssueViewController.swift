//
//  AddIssueViewController.swift
//  Lua
//
//  Created by Kevin on 11/17/17.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit
import WebKit

class AddIssueViewController: UIViewController, UITextViewDelegate, WKNavigationDelegate {

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var defaults = UserDefaults.standard
    var issueTitle: String! = ""
    var issueBody: String! = ""
    var issueURL: URL!
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.layer.borderWidth = 1
        bodyTextView.layer.borderWidth = 1
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if issueTitle == "" {
            let alertController = UIAlertController.init(title: "Error", message: "Need an issue title", preferredStyle: .alert)
            let okayAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        // Can use my repo URL to test creating issues. Replace issueURL with tempURL
        //  let tempURL = URL(string: "https://api.github.com/repos/kevin-moy/Jumping_Bird/issues")
        ApiManager.sharedInstance.createIssue(issueURL, issueTitle, issueBody: issueBody) { (success, error) in
            if Int(error!) == 404 {
                let alertController = UIAlertController.init(title: "Error", message: "You need to login ", preferredStyle: .alert)
                let okayAction = UIAlertAction.init(title: "Login", style: .default, handler: {(alert: UIAlertAction!) in
                    self.webView.navigationDelegate = self
                    let url = URL(string: "\(Github.authorizeURL)client_id=\(Github.clientID)&scope=repo")
                    
                    self.webView.frame = self.view.bounds
                    self.webView.load(URLRequest(url: url!))
                    self.view.addSubview(self.webView)
                })
                let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            if success && Int(error!) == 201 {
                let alertController = UIAlertController.init(title: "Success", message: "Created issue", preferredStyle: .alert)
                let okayAction = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let url = navigationResponse.response.url, let host = url.host, host.hasPrefix("www.google.com") {
            if let range = url.absoluteString.range(of: "code=") {
                let code = String(url.absoluteString.suffix(from: range.upperBound))
                ApiManager.sharedInstance.getAccessToken(code, completionHandler: { (success, accessCode, error) in
                    self.defaults.set(accessCode, forKey: defaultKeys.accessCode)
                    DispatchQueue.main.async {
                        webView.removeFromSuperview()
                    }
                })
            }
            decisionHandler(.allow)
        }
        else {
            decisionHandler(.allow)
        }
    }
}
