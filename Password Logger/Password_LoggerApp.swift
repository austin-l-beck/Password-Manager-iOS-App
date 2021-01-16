//
//  Password_LoggerApp.swift
//  Password Logger
//
//  Created by Austin Beck on 1/15/21.
//

import SwiftUI

@main
struct Password_LoggerApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(tempEmail: "", tempPassword: "")
        }
    }
}
