//
//  SidebarViewModel.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import Foundation
import Supabase

class SidebarViewModel: ObservableObject {
    
    enum State: Hashable {
        case intial
        case loading
        case loaded([SidebarSection])
        case error
    }
    
    @Published var state: State = .intial
    
    var sidebarSections: [SidebarSection] {
        switch state {
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
    func loadSidebarOptions(supabase: Supabase) async {
        self.state = .loading
        let query = supabase.client.database
            .from("SidebarSections")
            .select(foreignTable: "SidebarOptions")
        do {
            let result: PostgrestResponse<[SidebarSection]> = try await query.execute()
            print(result.underlyingResponse)
            self.state = .loaded(result.value)
        } catch {
            print(error)
            self.state = .error
        }
        
    }
    
}
