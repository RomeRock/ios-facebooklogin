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
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var nameAgeLabel: UILabel!
    @IBOutlet var profilePictureImageView: FBSDKProfilePictureView!
    
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
            loginButton.isHidden = true
            contentView.isHidden = false
            getInfo()
        } else {
            loginButton.isHidden = false
            contentView.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let login:FBSDKLoginManager = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile"], from: self) { result, error in
            if error != nil {
                print("error \(error?.localizedDescription)")
            } else if (result?.isCancelled)! {
                print("Cancelled")
            } else {
                print("login with \(result)")
                self.loginButton.isHidden = true
                self.contentView.isHidden = false
                self.getInfo()
            }
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        let logOut:FBSDKLoginManager = FBSDKLoginManager()
        logOut.logOut()
        loginButton.isHidden = false
        contentView.isHidden = true
    }
    
    func getInfo() {
        profilePictureImageView.profileID = "me"
        let requestMe:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, first_name, last_name, gender, link"], httpMethod: "GET")
        let connection:FBSDKGraphRequestConnection = FBSDKGraphRequestConnection()
        connection.add(requestMe) { (connection, result, error) -> Void in
            if (error == nil) {
                //if result
                let firstName:String = (result! as AnyObject).object(forKey:"first_name") as! String
                let lastName:String = (result! as AnyObject).object(forKey:"last_name") as! String
                let fullName = firstName + " " + lastName
                let gender:String = (result! as AnyObject).object(forKey:"gender") as! String
                
                let link:String = (result! as AnyObject).object(forKey:"link") as! String
                
                print(link)
                
                let name:String = (result! as AnyObject).object(forKey:"name") as! String
                
                print(name)
                
                self.nameAgeLabel.text = name
                self.genderLabel.text = gender.capitalized
                
            }
        }
        connection.start()/*
        FBSDKGraphRequest(graphPath: "me",
                          
                          parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email , gender, birthday"]).start(
                            
                            completionHandler: { (connection, result, error) -> Void in
                                
                                
                                if (error == nil)
                                    
                                {
                                    
                                    print((result! as AnyObject).object(forKey:"email")!)
                                    print((result! as AnyObject).object(forKey:"birthday")!)
                                    print((result! as AnyObject).object(forKey:"gender")!)
                                }})*/
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
