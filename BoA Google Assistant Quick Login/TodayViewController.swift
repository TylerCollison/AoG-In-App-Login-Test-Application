//
//  TodayViewController.swift
//  BoA Google Assistant Quick Login
//
//  Created by Tyler Collison on 8/1/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //The status label
    @IBOutlet weak var statusLabel: UILabel!
    //Stores the User's ID
    private var USER_ID: String = ""
    
    @IBAction func loginButton(_ sender: UIButton) {
        //Load the stored userId
        let DEFAULTS = UserDefaults(suiteName: Constants.SUITE_NAME);
        USER_ID = (DEFAULTS?.string(forKey: Constants.USER_ID_KEY))!;
        
        //Authenticate the conversation via the user ID
        try! AOGAuthentication.authenticate(conversationId: USER_ID);
        
        //Set the widget status
        statusLabel.text = Constants.READY_STRING;
        DEFAULTS?.set(Constants.READY_STRING, forKey: Constants.LOGIN_STATUS_KEY);
        DEFAULTS?.synchronize();
        
        //Update the UI with login status indicator
        updateStatusIndicator();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        //Setup the widget
        setup();
        
        //Update the widget's status
        updateStatusIndicator();
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        //Update the UI with login status indicator
        updateStatusIndicator();
        
        completionHandler(NCUpdateResult.newData)
    }
    
    ///Loads the stored user ID and last saved status
    private func setup() {
        //Load the stored userId
        let DEFAULTS = UserDefaults(suiteName: Constants.SUITE_NAME);
        USER_ID = (DEFAULTS?.string(forKey: Constants.USER_ID_KEY))!;
        
        //Set stored widget status
        if let status = DEFAULTS?.string(forKey: Constants.LOGIN_STATUS_KEY) {
            statusLabel.text = status;
        }
    }
    
    ///Updates the status indicator UI with current status from
    ///the server
    private func updateStatusIndicator() {
        //Load the stored userId
        let DEFAULTS = UserDefaults(suiteName: Constants.SUITE_NAME);
        USER_ID = (DEFAULTS?.string(forKey: Constants.USER_ID_KEY))!;
        
        //Check the login status and update the UI
        AOGAuthentication.checkLoginStatus(userId: USER_ID) { result in
            //Set the indicator
            DispatchQueue.main.async {
                self.statusLabel.text = result;
            }
            //Save the status of the widget
            DEFAULTS?.set(result, forKey: Constants.LOGIN_STATUS_KEY);
        }
    }
    
}
