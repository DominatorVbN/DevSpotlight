//
//  ContentView.swift
//  DevSpotlight
//
//  Created by Amit Samant on 09/10/23.
//

import SwiftUI

struct ContentView: View {
    let selectedOption: SidebarOption
    @Environment(\.supabase) var supabase
    @StateObject var viewModel = ContentViewModel()
    
    @Binding var selectedSpotlight: Spotlight?
    
    var list: some View {
        List(viewModel.spotlights, selection: $selectedSpotlight) { spotlight in
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: spotlight.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.secondary)
                        .frame(width: 100, height: 100)
                }
                VStack(alignment: .leading) {
                    Text(spotlight.title)
                    Text(spotlight.by)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .tag(spotlight)
        }
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
        await viewModel.loadSpotlight(forTag: selectedOption.tag, supabase: supabase)
    }
  }
}

#Preview {
    ContentView(selectedOption: .init(id: 1, icon: "brain", name: "Top Spotlight", tag: "top-spotlight"), selectedSpotlight: .constant(.init(id: 1, by: "Paul", title: "Some", imageURL: "", articleURL: "", tags: [""])))
}
