//
//  Card.swift
//  YuGiOh_Library
//
//  Created by Arkow on 20/10/2022.
//

import Foundation

struct Card: Codable {
    let id: Int
    let name: String
    let type: String
    let desc: String
    let cardImages: [ImageCard]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case desc = "desc"
        case cardImages = "card_images"
    }
}

struct ImageCard: Codable {
    
    let id: Int
    let imageURL: URL
    let imageURLSmall: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURL = "image_url"
        case imageURLSmall = "image_url_small"
    }
}

struct BaseCards: Decodable {
    let base: [Card]
    
    enum CodingKeys: String, CodingKey {
        case base = "data"
    }
}
