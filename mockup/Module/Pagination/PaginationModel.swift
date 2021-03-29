//
//  PaginationModel.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation

struct SaleItemRemote: Codable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case id = "dealID"
        case title
        case thumb
        case salePrice
        case normalPrice
        case steamRatingPercent
    }
    
    var id: String
    let title: String
    let thumb: String
    let salePrice: String
    let normalPrice: String
    let steamRatingPercent: String
    
    static let mock: SaleItemRemote = {
        SaleItemRemote(
            id: UUID().uuidString,
            title: "Sample title",
            thumb: "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
            salePrice: "9.99",
            normalPrice: "199.99",
            steamRatingPercent: "92"
        )
    }()
}
