//
//  ContentView.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import SwiftUI
import WebViewKit

struct MainView: View {
    @State private var path = NavigationPath()
    @State var selectedOption: SidebarOption?
    @State var selectedSpotlight: Spotlight?
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selectedOption: $selectedOption.animation())
                .navigationTitle("Spotlight")
        } content: {
            if let selectedOption = selectedOption {
                ContentView(selectedOption: selectedOption, selectedSpotlight: $selectedSpotlight.animation())
                    .id(selectedOption)
                    .navigationTitle(selectedOption.name)
            } else {
                Text("Select any topic")
            }
        } detail: {
            if let selectedSpotlight = selectedSpotlight {
                WebView(url: URL(string: selectedSpotlight.articleURL))
                    .id(selectedSpotlight)
                    .navigationTitle(selectedSpotlight.title)
            } else {
                Text("Select any spotlight")
            }
        }
    }
}

#Preview {
    MainView()
}
