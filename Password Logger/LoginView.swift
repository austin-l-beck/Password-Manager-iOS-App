//
//  LoginView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Text("Password Logger")
                .padding()
                .font(.headline)
            Text("Enter Username:")
            TextField("Username", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .frame(width: 200)
                .border(Color.black)
            Text("Enter Password:")
            SecureField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
                .frame(width:200)
                .border(Color.black)
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Create New Account")
            }
            .frame(width: 200)
            .border(Color.blue)
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
