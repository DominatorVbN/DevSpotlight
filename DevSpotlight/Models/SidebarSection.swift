//
//  SidebarSection.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import Foundation

struct SidebarSection: Codable, Identifiable, Hashable {
    
    var id: String
    var name: String
    var sidebarOptions: [SidebarOption]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sidebarOptions = "SidebarOptions"
    }
}
