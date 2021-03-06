//
//  AccountCreationViewModel.swift
//  Password Logger
//
//  Created by Austin Beck on 1/17/21.
//

import Foundation
import Security

class AccountCreationViewModel: ObservableObject {
    func addItem(username: String, password: String, accountName: String) {
        let keychainItem = [
            kSecValueData: password.data(using: .utf8)!,
            kSecAttrAccount: username,
            kSecAttrServer: "\(accountName)",
            kSecClass: kSecClassInternetPassword,
            kSecReturnData: true
        ] as CFDictionary
            
        let status = SecItemAdd(keychainItem, nil)
        print("Operation finished with status: \(status)")
    }
    
    func deleteItem(accountName: String) {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: "\(accountName)"
        ] as CFDictionary
        // removing previous entry for new account
        SecItemDelete(query)
    }
    
    func createAccount(email: String, password: String) {
        let keychainItem = [
            kSecValueData: password.data(using: .utf8)!,
            kSecAttrAccount: email,
            kSecAttrServer: "testing.com",
            kSecClass: kSecClassInternetPassword,
            kSecReturnData: true
        ] as CFDictionary
            
        let status = SecItemAdd(keychainItem, nil)
        print("Operation finished with status: \(status)")
    }
    
    func getLoginCredentials() -> (String, String) {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: "testing.com",
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        print("Operation finished with status: \(status)")
        let dic = result as! NSDictionary
        let passwordData = dic[kSecValueData] as! Data
        let storedPassword = String(data: passwordData, encoding: .utf8)!
        let username = dic[kSecAttrAccount] as! String
        return (username, storedPassword)
    }
    
    func searchItem(accountName: String) -> (String, String, String){
        let query = [
          kSecClass: kSecClassInternetPassword,
          kSecAttrServer: "\(accountName)",
          kSecReturnAttributes: true,
          kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        print("Operation finished with status: \(status)")
        if result != nil {
        let dic = result as! NSDictionary

        let username = dic[kSecAttrAccount] as! String
        let passwordData = dic[kSecValueData] as! Data
        let password = String(data: passwordData, encoding: .utf8)!
        let account = accountName
        
        return (account, username, password)
        } else {
            print("Error")
            return ("Not Found","Not Found","Not Found")
        }
    }
}
