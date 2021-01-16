//
//  LoginView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//

import SwiftUI

struct LoginView: View {
    @State var isAccountCreation = false
    // Unable to use firestore authentication as it requires a paid Developer program
    @State var email = "Testing@outlook.com"
    @State var password = "123456"
    @State var tempEmail: String
    @State var tempPassword: String
    @State private var passwordAccepted = false
    @State private var showError = false
    
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
                    // check to see if email and password entered match before logging in
                    if email == tempEmail && password == tempPassword {
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
            }
            .navigationBarTitle("Login", displayMode: .inline)
        }.background(Color.gray)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(tempEmail: "", tempPassword: "")
    }
}
