//
//  AccountCreationView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//
// This view is non functioning as I cannot get access to Firebase without a paid developer account

import SwiftUI
import Security

struct AccountCreationView: View {
    @Environment(\.presentationMode) var presentation
    @State var email = ""
    @State var password = ""
    @State private var password2 = ""
    @State var passwordsMatch = true
    let tapCount = UserDefaults.standard.integer(forKey: "accountTaps")
    
    var body: some View {
        VStack {
            Text("Account Creation")
                .font(.headline)
                .padding()
            Text("Enter Email")
            TextField("Email...", text: self.$email)
                .frame(width: 200)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(.black)
                .padding()
            Text("Enter Password")
            SecureField("...", text: self.$password)
                .frame(width:200)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(.black)
                .padding()
            Text("Confirm Password")
            SecureField("...", text: self.$password2)
                .frame(width:200)
                .border(Color.black)
                .background(Color.white)
                .foregroundColor(.black)
                .padding()
            if !passwordsMatch {
                Text("Passwords do no match.")
                    .foregroundColor(.red)
            }
            Button(action: {
                if password == password2 && tapCount == 0{
                    // creating new account information to store in keychain
                    let keychainItem = [
                        kSecValueData: password.data(using: .utf8)!,
                        kSecAttrAccount: email,
                        kSecAttrServer: "testing.com",
                        kSecClass: kSecClassInternetPassword,
                        kSecReturnData: true
                    ] as CFDictionary
                        
                    let status = SecItemAdd(keychainItem, nil)
                    
                    self.presentation.wrappedValue.dismiss()
                } else if password == password2 && tapCount != 0 {
                    let query = [
                        kSecClass: kSecClassInternetPassword,
                        kSecAttrServer: "testing.com"
                    ] as CFDictionary
                    // removing previous entry for new account
                    SecItemDelete(query)
                    //creating new account to store in keychain
                    let keychainItem = [
                        kSecValueData: password.data(using: .utf8)!,
                        kSecAttrAccount: email,
                        kSecAttrServer: "testing.com",
                        kSecClass: kSecClassInternetPassword,
                        kSecReturnData: true
                    ] as CFDictionary
                        
                    let status = SecItemAdd(keychainItem, nil)
                    
                    self.presentation.wrappedValue.dismiss()
                } else {
                    self.passwordsMatch = false
                }
                }) {
                Text("Create Account")
            }
            .frame(width:200)
            .border(Color.blue)
            .padding()
        }
    }
}

struct AccountCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreationView()
    }
}



