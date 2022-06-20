//
//  Checklist+CoreDataProperties.swift
//  ToDolListCoreData
//
//  Created by Карим Садыков on 20.06.2022.
//
//

import Foundation
import CoreData


extension Checklist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Checklist> {
        return NSFetchRequest<Checklist>(entityName: "Checklist")
    }

    @NSManaged public var name: String?
    @NSManaged public var item: NSSet?

}

// MARK: Generated accessors for item
extension Checklist {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: Item)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: Item)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}

extension Checklist : Identifiable {

}
