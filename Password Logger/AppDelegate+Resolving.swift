//
//  AppDelegate+Resolving.swift
//  Password Logger
//
//  Created by Austin Beck on 1/16/21.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { LocalAccountRepository() as AccountRepository }.scope(.application)
    }
}
