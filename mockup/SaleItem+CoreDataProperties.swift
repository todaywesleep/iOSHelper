//
//  SaleItem+CoreDataProperties.swift
//  
//
//  Created by Vladislav Erchik on 10.12.20.
//
//

import Foundation
import CoreData

extension SaleItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaleItem> {
        return NSFetchRequest<SaleItem>(entityName: "SaleItem")
    }

    @NSManaged public var id: String
    @NSManaged public var normalPrice: String
    @NSManaged public var salePrice: String
    @NSManaged public var steamRatingPercent: String
    @NSManaged public var thumb: String
    @NSManaged public var title: String
}
