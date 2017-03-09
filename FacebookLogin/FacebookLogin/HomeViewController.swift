//
//  HomeViewController.swift
//  FacebookLogin
//
//  Created by Rome Rock on 3/8/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    var titleLabel: UILabel!
    @IBOutlet var menuItem: UIBarButtonItem!
    @IBOutlet var contentView: UIView!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuItem.target = self.revealViewController()
            menuItem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().panGestureRecognizer().delegate = self
        }
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowRadius = 0
        contentView.layer.cornerRadius = 2
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.text = "MM: Facebook Login"
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        if (FBSDKAccessToken.current() != nil) {
            loginButton.isEnabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let login:FBSDKLoginManager = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile", "email"], from: self) { result, error in
            if error != nil {
                print("error \(error?.localizedDescription)")
            } else if (result?.isCancelled)! {
                print("Cancelled")
            } else {
                print("login with \(result)")
            }
        }
    }
    
    
    func getInfo() {
        let requestMe:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me?fields=first_name, last_name, picture, email", parameters: nil, httpMethod: "GET")
        let connection:FBSDKGraphRequestConnection = FBSDKGraphRequestConnection()
        connection.add(requestMe) { connection, result, error in
            if (result != nil) {
                //if result
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
