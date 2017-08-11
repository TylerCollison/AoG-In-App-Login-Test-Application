//
//  Request.swift
//  BofA Test Application
//
//  A serializable object for sending and receiving requests from the server
//
//  Created by Tyler Collison on 7/21/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation

///A serializable object for sending and receiving requests from the server
public class Request {
    ///Converts this object to a JSON string
    public func toJsonString() throws -> String {
        let jsonData = try JSONSerialization.data(withJSONObject: self.toDictionary(), options: JSONSerialization.WritingOptions.prettyPrinted);
        let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8);
        return jsonString!;
    }
    
    ///Converts this object to a dictionary of its properties
    ///
    ///This method should be overriden in subclasses
    public func toDictionary() -> Dictionary<String, String> {
        return Dictionary();
    }
}
