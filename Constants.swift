//
//  Constants.swift
//  BofA Test Application
//
//  Common constants
//
//  Created by Tyler Collison on 8/1/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation

//Common constants
public class Constants {
    ///Key for saving the user's Actions on Google ID
    public static let USER_ID_KEY = "userId";
    
    ///The suite name for this application group
    public static let SUITE_NAME = "group.boatestapplication";
    
    ///Default UI text for the "ready" status
    public static let READY_STRING = "ready";
    
    ///Key for saving the status of the widget
    public static let LOGIN_STATUS_KEY = "loginStatus";
    
    ///The fulfillment URL
    public static let FULFILLMENT_URL = "https://aog-fulfillment-in-app-login.herokuapp.com";
    
    ///Deeplink to the Google Assistant
    public static let GOOGLE_ASSISTANT_URL = "googleassistant://"
    
    ///Fulfillment server authentication route prefix
    public static let AUTHENTICATION_PREFIX = "authenticate";
    
    ///Fulfillment server status route prefix
    public static let STATUS_PREFIX = "status";
    
    ///User ID query string parameter name
    public static let USER_ID_QUERY_STRING = "user_id";
    
    ///The name of the JSON element containing the user's login
    ///status
    public static let JSON_STATUS_ELEMENT_NAME = "status";
}
