//
//  AccountSearchView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/17/21.
//

import SwiftUI

struct AccountSearchView: View {
    @State var tempAccountName = ""
    @State var password = ""
    @State var username = ""
    @State var isSearchComplete = false
    @State var isAddAccount = false
    @ObservedObject var accountCreationVM = AccountCreationViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Enter account name to search below: ")
            TextField("Account Name..", text: $tempAccountName)
                .frame(width: 200)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(.black)
                .padding()
            Button(action: {
                let query = [
                  kSecClass: kSecClassInternetPassword,
                  kSecAttrServer: "\(tempAccountName)",
                  kSecReturnAttributes: true,
                  kSecReturnData: true
                ] as CFDictionary

                var result: AnyObject?
                let status = SecItemCopyMatching(query, &result)

                print("Operation finished with status: \(status)")
                let dic = result as! NSDictionary

                username = dic[kSecAttrAccount] as! String
                let passwordData = dic[kSecValueData] as! Data
                password = String(data: passwordData, encoding: .utf8)!
                isSearchComplete.toggle()
            }) {
                Text("Search")
            }
            if isSearchComplete {
                HStack {
                    Text("Account Name: ")
                    Text(tempAccountName)
                }
                HStack {
                    Text("Username: ")
                    Text(username)
                }
                HStack {
                    Text("Password: ")
                    Text(password)
                }
            } else {
                Text("No account information")
                    .padding()
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isAddAccount.toggle()
                }) {
                    Text("Add Account")
                }
                Spacer()
            }.sheet(isPresented: $isAddAccount) {
                AddingAccountsView()
            }
        }
    }
}

struct AccountSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSearchView()
    }
}
