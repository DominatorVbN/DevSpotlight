//
//  ContentViewModel.swift
//  DevSpotlight
//
//  Created by Amit Samant on 09/10/23.
//

import Foundation
import Supabase

protocol DataBaseProvider {
    func spotlights(forTag tag: String) throws -> [Spotlight]
}


class ContentViewModel: ObservableObject {
    
    enum State {
        case intial
        case loading
        case loaded([Spotlight])
        case error
    }
    
    @Published var state: State = .intial
    
    var spotlights: [Spotlight] {
        switch self.state {
        case .intial:
            return []
        case .loading:
            return []
        case .loaded(let array):
            return array
        case .error:
            return []
        }
    }
    
    @MainActor
    func loadSpotlight(forTag tag: String, supabase: Supabase) async {
        self.state = .loading
        let query = supabase.client.database
            .from("Spotlights")
            .select()
            .contains(column: "tags", value: [tag])
        do {
            let result: PostgrestResponse<[Spotlight]> = try await query.execute()
            print(result.underlyingResponse)
            self.state = .loaded(result.value)
        } catch {
            print(error)
            self.state = .error
        }
        
    }
}
