//
//  AccountSearchView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/17/21.
//

import SwiftUI

struct AccountSearchView: View {
    @State var tempAccountName = ""
    @State var setPassword = ""
    @State var setUsername = ""
    @State var accountName = ""
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
                let (account, username, password) = accountCreationVM.searchItem(accountName: tempAccountName)
                setPassword = password
                setUsername = username
                accountName = account
                isSearchComplete.toggle()
            }) {
                Text("Search")
            }.padding()

            if isSearchComplete {
                HStack {
                    Text("Account Name: ")
                    Text(accountName)
                }
                HStack {
                    Text("Username: ")
                    Text(setUsername)
                }
                HStack {
                    Text("Password: ")
                    Text(setPassword)
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
