//
//  RequestCompletionListener.swift
//  BofA Test Application
//
//  Created by Tyler Collison on 8/2/17.
//  Copyright © 2017 Bank of America. All rights reserved.
//

import Foundation

public protocol RequestCompleteListener {
    func execute (result: String)
}
