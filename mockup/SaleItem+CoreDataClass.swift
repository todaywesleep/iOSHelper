//
//  SaleItem+CoreDataClass.swift
//  
//
//  Created by Vladislav Erchik on 10.12.20.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

@objc(SaleItem)
public class SaleItem: NSManagedObject, Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "dealID"
        case normalPrice
        case salePrice
        case steamRatingPercent
        case thumb
        case title
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw NSError(domain: "Error when fetching context", code: 100, userInfo: nil)
        }
        
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.normalPrice = try container.decode(String.self, forKey: .normalPrice)
        self.salePrice = try container.decode(String.self, forKey: .salePrice)
        self.steamRatingPercent = try container.decode(String.self, forKey: .steamRatingPercent)
        self.thumb = try container.decode(String.self, forKey: .thumb)
        self.title = try container.decode(String.self, forKey: .title)
    }
}

// MARK: Mock
extension SaleItem {
    static var mock: SaleItem {
        let saleItem = SaleItem()
        saleItem.id = "testId"
        saleItem.normalPrice = "23.34"
        saleItem.salePrice = "3.34"
        saleItem.steamRatingPercent = "91"
        saleItem.thumb = ""
        saleItem.title = "Test title"
        
        return saleItem
    }
}
