//
//  AddingAccounts.swift
//  Password Logger
//
//  Created by Austin Beck on 1/17/21.
//

import SwiftUI
import Security

struct AddingAccountsView: View {
    @Environment(\.presentationMode) var presentation
    @State var tempUsername = ""
    @State var tempPassword = ""
    @State var tempAccountName = ""
    @ObservedObject var accountCreationVM = AccountCreationViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text("Enter Account Name: ")
                TextField("Account Name...", text: $tempAccountName)
            }.padding()
            HStack{
                Text("Enter Username: ")
                TextField("Username...", text: $tempUsername)
            }.padding()
            HStack {
                Text("Enter Password: ")
                TextField("Password...", text: $tempPassword)
            }.padding()
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    accountCreationVM.addItem(username: tempUsername, password: tempPassword, accountName: tempAccountName)
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Add Account")
                }
                Spacer()
            }
        }
    }
}

struct AddingAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AddingAccountsView()
    }
}
