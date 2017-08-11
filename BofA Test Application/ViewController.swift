//
//  ViewController.swift
//  BofA Test Application
//
//  Created by Tyler Collison on 7/14/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func loginButton(_ sender: Any) {
        //Load the stored userId
        let defaults = UserDefaults(suiteName: Constants.SUITE_NAME);
        if let userId = defaults?.string(forKey: Constants.USER_ID_KEY) {
            //Authenticate the conversation via the user ID
            try! AOGAuthentication.authenticate(conversationId: userId);
        }
    }
}

