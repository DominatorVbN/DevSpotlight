//
//  DevSpotlightApp.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import SwiftUI
import SwiftData

@main
struct DevSpotlightApp: App {
    let supabase = Supabase()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.supabase, supabase)
        }
    }
}
