//
//  AuthView.swift
//  DevSpotlight
//
//  Created by Amit Samant on 15/10/23.
//

import SwiftUI

import SwiftUI
import AuthenticationServices
import Supabase
import GoTrue

struct AuthView: View {
    @Environment(\.supabase) var supabase    
    let onSuceess: (Session) -> Void
    
    var body: some View {
        SignInWithAppleButton { request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            Task {
                do {
                    guard let credential = try result.get().credential as? ASAuthorizationAppleIDCredential
                    else {
                        return
                    }
                    
                    guard let idToken = credential.identityToken
                        .flatMap({ String(data: $0, encoding: .utf8) })
                    else {
                        return
                    }
                    let session = try await supabase.client.auth.signInWithIdToken(
                        credentials: .init(
                            provider: .apple,
                            idToken: idToken
                        )
                    )
                    onSuceess(session)
                } catch {
                    dump(error)
                }
            }
        }
        .fixedSize()
    }
}

#Preview {
    AuthView { _ in
        
    }
}
