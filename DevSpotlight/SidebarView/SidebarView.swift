//
//  SidebarView.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import SwiftUI

struct SidebarView: View {
    
    @Environment(\.supabase) var supabase
    @StateObject var viewModel = SidebarViewModel()
    @Binding var selectedOption: SidebarOption?
    
    var list: some View {
        List(selection: $selectedOption) {
            ForEach(viewModel.sidebarSections) { section in
                Section(section.name) {
                    ForEach(section.sidebarOptions) { option in
                        Label(
                            option.name,
                            systemImage: option.icon
                        )
                        .tag(option)
                    }
                }
            }
        }
//        .toolbar(content: {
//            Button {
//                Task {
//                    do {
//                        try await supabase.client.auth.signOut()
//                        supabase.session = nil
//                    } catch {
//                        print(error)
//                    }
//                }
//            } label: {
//                Text("Exit")
//            }
//
//        })
    }
    
  var body: some View {
    Group {
      switch viewModel.state {
      case .intial:
        ProgressView()
      case .loading:
        ProgressView()
      case .loaded:
        list
      case .error:
        Text("Error occured")
      }
    }
    .task {
        await viewModel.loadSidebarOptions(supabase: supabase)
    }
  }

}
