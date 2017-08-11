//
//  AOGSetupDeepLinkProcessor.swift
//  BofA Test Application
//
//  Provides functions for processing deep links for remote login setup requests
//
//  Created by Tyler Collison on 8/1/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation
import UIKit

///Provides functions for processing deep links for remote login setup requests
public class AOGSetupDeepLinkProcessor : DeepLinkProcessor {
    
    ///Expected protocol type
    private static let SCHEME = "bofa";
    ///Expected host name
    private static let HOST = "ghsetup";
    ///Expected parameter
    private static let USER_ID_PARAMETER_NAME = "user_id";
    
    ///Process the deep link for Actions on Google in-app Google Home setup
    ///
    ///@param url: The deep link URL to evaluate
    ///
    ///@return Returns whether the deep link is valid for
    ///Actions on Google in-app Google Home setup
    public static func processDeepLinkForSetup(url: URL) throws -> Bool {
        //Validate the deep link
        var isValid = validateDeepLink(scheme: SCHEME, host: HOST, url: url);
        
        if (isValid) {
            //Validate required query string parameter
            let queryMap = parseQueryMap(queryString: url.query!);
            //Determine whether a user id was provided
            if let userId = queryMap[USER_ID_PARAMETER_NAME] {
                //Save the user's ID
                saveUserId(userId: userId);
            } else {
                //The query string is missing a parameter
                isValid = false;
            }
        }
        
        //Return to the Google Assistant
        let returnURL = URL(string: Constants.GOOGLE_ASSISTANT_URL);
        UIApplication.shared.open(returnURL!);
        
        return isValid;
    }
    
    ///Save the User ID to User Defaults
    ///
    ///@param userId: The user ID to save
    private static func saveUserId(userId: String) {
        //Save user ID for use by the login extension widget
        if let defaults = UserDefaults(suiteName: Constants.SUITE_NAME) {
            defaults.set(userId, forKey: Constants.USER_ID_KEY);
            defaults.synchronize();
        }
    }
}
