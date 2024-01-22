//
//  DevSpotlightApp.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import SwiftUI
import SwiftData
import Supabase

@main
struct DevSpotlightApp: App {
    @StateObject var supabase = Supabase()
    
    var body: some Scene {
        WindowGroup {
            if supabase.session != nil {
                MainView()
                    .environment(\.supabase, supabase)
            } else {
                AuthView { session in
                    self.supabase.session = session
                }
            }
        }
    }
}
