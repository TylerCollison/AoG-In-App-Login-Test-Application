//
//  AOGAuthentication.swift
//  BofA Test Application
//
//  Provides functions for authenticating users with Actions on Google
//
//  Created by Tyler Collison on 7/21/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation

///Provides functions for authenticating users with Actions on Google
public class AOGAuthentication {
    ///The OK response from the server
    private static let OK_RESPONSE = 200;
    
    ///Sends an authentication request to the fulfillment for the 
    ///given conversation
    ///
    ///@param conversationId: The conversation to
    ///authenticate
    public static func authenticate(conversationId: String) throws {
        //Set the fulfillment server authentication route as the URL
        let url = URL(string: Constants.FULFILLMENT_URL + "/" + Constants.AUTHENTICATION_PREFIX);
        var urlRequest = URLRequest(url: url!);
        
        //This is a POST request
        urlRequest.httpMethod = "POST";
        
        //Specify JSON body type
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type");
        
        //Get the JSON authentication request
        let jsonReq = AuthenticationRequest(conversationId: conversationId);
        let jsonReqString = try jsonReq.toJsonString();
        
        //Set the JSON authentication request body
        urlRequest.httpBody = jsonReqString.data(using: String.Encoding.utf8);
        
        //Create a new session
        let config = URLSessionConfiguration.default;
        let session = URLSession(configuration: config);
        
        //Send authentication request to server
        let task = session.dataTask(with: urlRequest);
        task.resume();
    }
    
    ///Checks the login status of the specified user and returns the result to the callback
    ///
    ///@param userId: The Google ID associated with the user
    ///
    ///@param completion: The completion callback function
    public static func checkLoginStatus(userId: String, completion: @escaping (String) -> Void) {
        //Set the fulfillment server status route as the url
        let url = URL(string: Constants.FULFILLMENT_URL + "/" + Constants.STATUS_PREFIX + "?" + Constants.USER_ID_QUERY_STRING + "=" + userId);
        var urlRequest = URLRequest(url: url!);
        
        //This is a GET request
        urlRequest.httpMethod = "GET";
        
        //Create a new session
        let config = URLSessionConfiguration.default;
        let session = URLSession(configuration: config);
        
        //Send status request to server
        let task = session.dataTask(with: urlRequest) { data, response, error in
            //Determine whether the request was successful
            let httpResponse = response as? HTTPURLResponse;
            if (httpResponse?.statusCode == OK_RESPONSE) {
                //Get the response as a dictionary
                let jsonResponse = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, String>;
                //Retreive the status of the user
                let status = jsonResponse[Constants.JSON_STATUS_ELEMENT_NAME];
                //Call the callback handler with the status
                completion(status!);
            }
        }
        task.resume();
    }
}
