//
//  LoginView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//

import SwiftUI
import Security

struct LoginView: View {
    @State var isAccountCreation = false
    // Unable to use firestore authentication as it requires a paid Developer program
    @State var email = "Testing@outlook.com"
    @State var password = "123456"
    @State var tempEmail: String
    @State var tempPassword: String
    @State private var passwordAccepted = false
    @State private var showError = false
    @State var accountTaps = 0
    var ref: AnyObject?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Password Logger")
                    .padding()
                    .font(.headline)
                Text("Enter Email:")
                TextField("Email..", text: $tempEmail)
                    .frame(width: 200)
                    .border(Color.black)
                Text("Enter Password:")
                SecureField("Password", text: $tempPassword)
                    .frame(width:200)
                    .border(Color.black)
                if showError == true {
                    Text("Incorrect Password")
                        .foregroundColor(.red)
                }
                Button(action: {
                    let query = [
                        kSecClass: kSecClassInternetPassword,
                        kSecAttrServer: "testing.com",
                        kSecReturnAttributes: true,
                        kSecReturnData: true
                    ] as CFDictionary
                    var result: AnyObject?
                    let status = SecItemCopyMatching(query, &result)
                    let dic = result as! NSDictionary
                    let passwordData = dic[kSecValueData] as! Data
                    let storedPassword = String(data: passwordData, encoding: .utf8)!
                    let username = dic[kSecAttrAccount] ?? ""
                        // check to see if email and password entered match before logging in
                    if tempEmail == username as! String && tempPassword == storedPassword {
                            self.passwordAccepted.toggle()
                        } else {
                            // if information doesn't match, throws error message
                            self.showError.toggle()
                    }
                    
                }) {
                    Text("Login")
                }.sheet(isPresented: $passwordAccepted) {
                    AccountsView()
                }
                .padding()
                Button(action: {
                    isAccountCreation.toggle()
                    self.accountTaps += 1
                    UserDefaults.standard.set(self.accountTaps, forKey: "accountTaps")
                }) {
                    Text("Create Account")
                }.sheet(isPresented: $isAccountCreation) {
                    AccountCreationView()
                }
            }
            .navigationBarTitle("Login", displayMode: .inline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(tempEmail: "", tempPassword: "")
    }
}
