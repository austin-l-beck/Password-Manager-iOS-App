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
                    .background(Color.white)
                    .foregroundColor(.black)
                Text("Enter Password:")
                SecureField("Password", text: $tempPassword)
                    .frame(width:200)
                    .border(Color.black)
                    .background(Color.white)
                    .foregroundColor(.black)
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
                }.padding()
                
                Button(action: {
                    isAccountCreation.toggle()
                    self.accountTaps += 1
                    UserDefaults.standard.set(self.accountTaps, forKey: "accountTaps")
                }) {
                    Text("Create Account")
                }.sheet(isPresented: $isAccountCreation) {
                    AccountCreationView()
                }.padding()
                
                if passwordAccepted {
                    NavigationLink(destination: AccountsView()) {
                        Text("View Accounts")
                    } .padding()
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
