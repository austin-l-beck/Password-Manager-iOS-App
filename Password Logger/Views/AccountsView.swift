//
//  AccountsView.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//

import SwiftUI

struct AccountsView: View {
    @ObservedObject var passwordListVM = PasswordListViewModel()
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach (passwordListVM.passwordsCellViewModels) {
                        passwordCellVM in AccountCell(passwordsCellVM: passwordCellVM)
                    }
                    .onDelete { indexSet in
                        self.passwordListVM.removeAccount(atOffsets: indexSet)
                    }
                    if presentAddNewItem {
                        AccountCell(passwordsCellVM: PasswordCellViewModel.newAccount()) { result in
                            if case .success(let account) = result {
                                self.passwordListVM.addAccount(account: account)
                            }
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                Button(action: { self.presentAddNewItem.toggle()}) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Password")
                    }
                }
                .padding()
                .accentColor(Color(UIColor.systemBlue))
                .navigationBarTitle("Passwords")
            }
        }
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView()
    }
}

struct AccountCell: View {
    @ObservedObject var passwordsCellVM: PasswordCellViewModel
    var onCommit: (Result<Accounts, InputError>) -> Void = {_ in}
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Account Name: ")
                Spacer()
                TextField("Enter Account Name", text: $passwordsCellVM.account.name)
                Spacer()
            }
            HStack {
                Spacer()
                Text("Username: ")
                Spacer()
                TextField("Enter Username", text: $passwordsCellVM.account.username)
                Spacer()
            }
            HStack {
                Spacer()
                Text("Password: ")
                Spacer()
                TextField("Enter Password", text: $passwordsCellVM.account.password,
                          onCommit: {
                            if !self.passwordsCellVM.account.name.isEmpty{
                                self.onCommit(.success(self.passwordsCellVM.account))
                            } else {
                                self.onCommit(.failure(.empty))
                            }
                          }).id(passwordsCellVM.id)
                Spacer()
            }
        }
    }
}

enum InputError: Error {
    case empty
}

