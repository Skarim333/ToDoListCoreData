//
//  Item+CoreDataProperties.swift
//  ToDolListCoreData
//
//  Created by Карим Садыков on 20.06.2022.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var done: Bool
    @NSManaged public var title: String?
    @NSManaged public var checklist: Checklist?

}

extension Item : Identifiable {

}
