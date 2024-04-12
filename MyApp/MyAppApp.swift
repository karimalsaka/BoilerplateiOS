//
//  MyAppApp.swift
//  MyApp
//
//  Created by Karim Alsaka on 12/04/2024.
//

import SwiftUI

@main
struct MyAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView()
            }
        }
    }
}
