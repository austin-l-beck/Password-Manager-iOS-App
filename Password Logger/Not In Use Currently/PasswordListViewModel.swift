//
//  PasswordListViewModel.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//

import Foundation
import Combine
import Resolver

class PasswordListViewModel: ObservableObject {
    @Published var passwordsCellViewModels = [PasswordCellViewModel]()
    @Published var accountRepository: AccountRepository = Resolver.resolve()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        accountRepository.$accounts.map { accounts in
            accounts.map { account in
                PasswordCellViewModel(account: account)
            }
        }
        .assign(to: \.passwordsCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    // function to remove accounts from the repo
    func removeAccount(atOffsets indexSet: IndexSet) {
        let viewModels = indexSet.lazy.map { self.passwordsCellViewModels[$0]}
        viewModels.forEach { passwordsCellViewModel in
            accountRepository.removeAccount(passwordsCellViewModel.account)
        }
    }
    // function to append an account to our running list
    func addAccount(account: Accounts) {
        accountRepository.addAccount(account)
    }
}
