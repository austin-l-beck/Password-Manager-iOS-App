//
//  Accounts.swift
//  Password Logger
//  Model for our Accounts 
//  Created by Austin Beck on 1/15/21.
//

import Foundation
import CoreData

struct Accounts: Identifiable, Codable {
    var id: String = UUID().uuidString
    var username: String
    var password: String
    var name: String
}

#if DEBUG
let testAccounts = [
    Accounts(username: "Testing1", password: "123456", name: "Apple"),
    Accounts(username: "Testing2", password: "987654", name: "Target"),
    Accounts(username: "Testing 3", password: "172364", name: "Walmart")
]
#endif
