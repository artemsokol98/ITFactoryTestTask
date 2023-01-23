//
//  JSONModel.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import Foundation

// MARK: - MainModel
struct JSONModel: Decodable {
    let sections: [Section]
}

// MARK: - Section
struct Section: Decodable {
    let id, header: String
    let itemsTotal, itemsToShow: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Decodable {
    let id: String
    let image: Image
    let title: String
}

// MARK: - Image
struct Image: Decodable {
    let the1X, the2X, the3X: String
    let aspectRatio: Int?
    let loopAnimation: Bool?

    enum CodingKeys: String, CodingKey {
        case the1X = "1x"
        case the2X = "2x"
        case the3X = "3x"
        case aspectRatio, loopAnimation
    }
}
