//
//  Supabase.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import Foundation
import Supabase
import SwiftUI

class Supabase {
    let host: String = Secrets.supabaseHost
    let key: String = Secrets.supabaseAPIKey
    
    lazy var client = SupabaseClient(
        supabaseURL: URL(string: host)!,
        supabaseKey: key)
}


struct SupabaseEnvironmentKey: EnvironmentKey {
    static var defaultValue: Supabase = Supabase()
}

extension EnvironmentValues {
    var supabase: Supabase {
        get { self[SupabaseEnvironmentKey.self] }
        set { self[SupabaseEnvironmentKey.self] = newValue }
    }
}
