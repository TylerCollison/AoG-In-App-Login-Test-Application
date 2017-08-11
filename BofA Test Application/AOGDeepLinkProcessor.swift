//
//  AOGDeepLinkProcessor.swift
//  BofA Test Application
//
//  Provides functions for processing deep links for login requests
//
//  Created by Tyler Collison on 7/21/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation
import UIKit

///Provides functions for processing deep links for login requests
public class AOGDeepLinkProcessor : DeepLinkProcessor {
    
    ///Expected protocol type
    private static let SCHEME = "bofa";
    ///Expected host name
    private static let HOST = "aog";
    ///Expected parameter
    private static let CONVERSATION_ID_PARAMETER_NAME = "conversation_id";
    
    ///Process the deep link for Actions on Google in-app
    ///authentication
    ///
    ///@param url: The deep link URL to evaluate
    ///
    ///@return Returns whether the deep link is valid for 
    ///Actions on Google in-app authentication
    public static func processDeepLinkForAuth(url: URL) throws -> Bool {
        //Validate the deep link
        var isValid = validateDeepLink(scheme: SCHEME, host: HOST, url: url);
        
        if (isValid) {
            //Validate required query string parameter
            let queryMap = parseQueryMap(queryString: url.query!);
            //Determine whether a conversation id was provided
            if let conversationId = queryMap[CONVERSATION_ID_PARAMETER_NAME] {
                //Send authentication information for user
                try AOGAuthentication.authenticate(conversationId: conversationId);
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
}
