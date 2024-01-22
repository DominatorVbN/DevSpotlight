//
//  Supabase.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import Foundation
import Supabase
import SwiftUI

class Supabase: ObservableObject {
    let userSessionKey = "Supabase.Session"
    let host: String = Secrets.supabaseHost
    let key: String = Secrets.supabaseAPIKey
    @Published var session: Session? = nil {
        didSet {
            DispatchQueue.global(qos: .userInitiated).async {
                try? self.saveUserSession(session: self.session)
            }
        }
    }
    
    lazy var client = SupabaseClient(
        supabaseURL: URL(string: host)!,
        supabaseKey: key
    )
    
    init() {
        self.session = getUserSession()
    }
    
    func saveUserSession(session: Session?) throws {
        guard let session = session else {
            KeychainHelper.standard.delete(service: "supabase", account: "com.supabase")
            return
        }
        let data = try JSONEncoder().encode(session)
        KeychainHelper.standard.save(data, service: "supabase", account: "com.supabase")
    }
    
    func getUserSession() -> Session? {
        return KeychainHelper.standard.read(service: "supabase", account: "com.supabase", type: Session.self)
    }
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
