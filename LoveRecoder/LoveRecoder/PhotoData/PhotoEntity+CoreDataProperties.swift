//
//  PhotoEntity+CoreDataProperties.swift
//  LoveRecoder
//
//  Created by Blacour on 2022/1/3.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var photoImage: Data?
    @NSManaged public var des: String?
    @NSManaged public var num: Int32
    @NSManaged public var width: Float
    @NSManaged public var height: Float

}

extension PhotoEntity : Identifiable {

}
