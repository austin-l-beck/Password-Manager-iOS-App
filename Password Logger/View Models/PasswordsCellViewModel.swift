//
//  PasswordsCellViewModel.swift
//  Password Logger
//  View Model for the Passwords/Accounts cell
//  Created by Austin Beck on 1/15/21.
//

import Foundation
import Combine

class PasswordCellViewModel: ObservableObject, Identifiable {
    @Published var account: Accounts
    
    var id: String = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    // Function to create new account with parameters 
    static func newAccount() -> PasswordCellViewModel {
        PasswordCellViewModel(account: Accounts(username: "", password: "", name: ""))
    }
    
    init(account: Accounts) {
        self.account = account
        
        $account
            .map { $0.id }
            .assign (to: \.id, on: self)
            .store(in: &cancellables)
    }
}
