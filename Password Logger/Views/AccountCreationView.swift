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
   
   
    
    var body: some View {
        VStack {
            Text("Account Creation")
                .font(.headline)
                .padding()
            Text("Enter Email")
            TextField("Email...", text: self.$email)
                .frame(width: 200)
                .border(Color.black)
            Text("Enter Password")
            SecureField("...", text: self.$password)
                .frame(width:200)
                .border(Color.black)
            Text("Confirm Password")
            SecureField("...", text: self.$password2)
                .frame(width:200)
                .border(Color.black)
            Button(action: {
                UserDefaults.standard.set(self.email, forKey: "Email")
                UserDefaults.standard.set(self.password, forKey: "Password")
                print(UserDefaults.standard.string(forKey: "Email")!)
                if password == password2 {
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



