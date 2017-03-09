//
//  MenuViewController.swift
//  SchemaColor
//
//  Created by NDM on 2/25/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string:"https://www.facebook.com/337180269970605")!)
    }

    @IBAction func twitterButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string:"https://twitter.com/RomeRock_Apps")!)
    }
    
    @IBAction func githubButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string:"https://github.com/RomeRock")!)
    }
    
    @IBAction func romerockButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string:"http://romerock.com")!)
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
