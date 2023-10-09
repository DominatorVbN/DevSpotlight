//
//  Spotlight.swift
//  DevSpotlight
//
//  Created by Amit Samant on 09/10/23.
//

import Foundation

struct Spotlight: Codable, Identifiable, Hashable {
    let id: Int
    let by: String
    let title: String
    let imageURL: String
    let articleURL: String
    let tags: [String]
}
