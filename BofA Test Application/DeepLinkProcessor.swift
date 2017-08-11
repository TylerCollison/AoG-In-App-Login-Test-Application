//
//  DeepLinkProcessor.swift
//  BofA Test Application
//
//  Provides functions for processing deep links
//
//  Created by Tyler Collison on 7/21/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation

///Provides functions for processing deep links
public class DeepLinkProcessor {
    ///Determines whether the deep link is valid
    ///
    /// @param scheme: The expected deep link protocol
    ///
    /// @param host: The expected deep link host
    ///
    /// @param url: The deep link url
    public static func validateDeepLink(scheme: String, host: String, url: URL) -> Bool {
        var isValid = false;
        //Validate the deep link scheme
        if (url.scheme == scheme) {
            //Validate relative path
            if (url.host == host) {
                //The deep link is valid
                isValid = true;
            }
        }
        return isValid;
    }
    
    ///Parses the given query string into a map of parameter
    ///key/value pairs.
    ///
    /// @param queryString: The query string to parse
    public static func parseQueryMap(queryString: String) -> Dictionary<String, String> {
        var result = Dictionary<String, String>();
        
        //Separate query string into array of key/value pairs
        let queryStringArray = queryString.characters.split(separator: "&").map(String.init);
        //Load each key/value pair of the query string into the map
        for var i in 0..<queryStringArray.count {
            let keyValuePairString = queryStringArray[i];
            let keyValuePair = keyValuePairString.characters.split(separator: "=").map(String.init);
            let key = keyValuePair[0];
            let value = keyValuePair[1];
            result[key] = value;
        }
        
        return result;
    }
}
