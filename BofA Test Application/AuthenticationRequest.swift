//
//  AuthenticationRequest.swift
//  BofA Test Application
//
//  A serializable object for sending an authentication request to the server
//
//  Created by Tyler Collison on 7/21/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation

///A serializable object for sending an authentication request to the server
public class AuthenticationRequest: Request {
    ///The conversation ID
    private var conversation_id = "";
    ///The access token
    //TODO: acquire access token for meaningful data
    //This access token is provided for example purposes only
    //This access token should be replaced with a meaningful token
    private let access_token = "iosapp12345";
    
    init(conversationId: String) {
        conversation_id = conversationId;
    }
    
    override public func toDictionary() -> Dictionary<String, String> {
        return ["conversation_id" : conversation_id, "access_token" : access_token];
    }
}
