//
//  AddingAccounts.swift
//  Password Logger
//
//  Created by Austin Beck on 1/17/21.
//

import SwiftUI
import Security

struct AddingAccountsView: View {
    @State var tempUsername = ""
    @State var tempPassword = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("Enter Username: ")
                TextField("Username...", text: $tempUsername)
            }
            HStack {
                Text("Enter Password: ")
                TextField("Password...", text: $tempPassword)
            }
            Button(action: {
                let keychainItem = [
                    kSecValueData: tempPassword.data(using: .utf8)!,
                    kSecAttrAccount: tempUsername,
                    kSecAttrServer: "testing.com",
                    kSecClass: kSecClassInternetPassword,
                    kSecReturnData: true
                ] as CFDictionary
                let status = SecItemAdd(keychainItem, nil)
            }) {
                Text("Add Account")
            }
        }
    }
}

struct AddingAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AddingAccountsView()
    }
}
