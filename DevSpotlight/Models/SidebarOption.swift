//
//  SidebarOption.swift
//  DevSpotlight
//
//  Created by Amit Samant on 08/10/23.
//

import Foundation

struct SidebarOption: Codable, Identifiable, Hashable {
    var id: Int
    var icon: String
    var name: String
    var tag: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case icon
        case name
        case tag
    }
}
