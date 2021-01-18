//
//  LoginView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//

import SwiftUI
import Security

struct LoginView: View {
    @ObservedObject var accountCreationVM = AccountCreationViewModel()
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
                    let (username, storedPassword) = accountCreationVM.getLoginCredentials()                        // check to see if email and password entered match before logging in
                    if tempEmail == username && tempPassword == storedPassword {
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
                    NavigationLink(destination: AccountSearchView()) {
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
