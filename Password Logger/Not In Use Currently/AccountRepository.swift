//
//  AccountRepository.swift
//  Password Logger
//  Repository creation for storing the password information 
//  Created by Austin Beck on 1/16/21.
//
// Not being used in current iteration as I am storing data in Keychain instead

import Foundation
import Resolver
import Disk
import Combine

class BaseAccountRepository {
    @Published var accounts = [Accounts]()
}

protocol AccountRepository: BaseAccountRepository {
    func addAccount(_ account: Accounts)
    func removeAccount(_ account: Accounts)
    func updateAccount(_ account: Accounts)
}

class TestDataAccountRepository: BaseAccountRepository, AccountRepository, ObservableObject {
    override init() {
        super.init()
        self.accounts = testAccounts
    }
    
    func addAccount(_ account: Accounts) {
        accounts.append(account)
    }
    
    func removeAccount(_ account: Accounts) {
        if let index = accounts.firstIndex(where: { $0.id == account.id}) {
            accounts.remove(at: index)
        }
    }
    
    func updateAccount(_ account: Accounts) {
        if let index = self.accounts.firstIndex(where: { $0.id == account.id}) {
        self.accounts[index] = account
        }
    }
}

class LocalAccountRepository: BaseAccountRepository, AccountRepository, ObservableObject {
    override init() {
        super.init()
        loadData()
    }
    
    func addAccount(_ account: Accounts) {
        self.accounts.append(account)
        saveData()
    }
    
    func removeAccount(_ account: Accounts) {
        if let index = accounts.firstIndex(where: { $0.id == account.id}) {
            accounts.remove(at: index)
            saveData()
        }
    }
    
    func updateAccount(_ account: Accounts) {
        if let index = self.accounts.firstIndex(where: { $0.id == account.id}) {
            self.accounts[index] = account
            saveData()
        }
    }
    
    private func loadData() {
        if let retrievedAccounts = try? Disk.retrieve("accounts.json", from: .documents, as: [Accounts].self) {
            self.accounts = retrievedAccounts
        }
    }
    
    private func saveData() {
        do {
            try Disk.save(self.accounts, to: .documents, as: "accounts.json")
        }
        catch let error as NSError {
            fatalError("""
                Domain: \(error.domain)
                Code: \(error.code)
                Description: \(error.localizedDescription)
                Failure Reason: \(error.localizedFailureReason ?? "")
                Suggestions: \(error.localizedRecoverySuggestion ?? "")
                """)
        }
    }
}
