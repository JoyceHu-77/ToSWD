//
//  DataModel.swift
//  collectionViewTest
//
//  Created by Blacour on 2021/10/21.
//

import Foundation
import UIKit

class DataModel: NSObject {
    var image: UIImage?
    var cellWidth: CGFloat?
    var cellHeight: CGFloat?
    var labelTitle: String?
    let labelHeight: CGFloat = 50
    
    var entityData: PhotoEntity?
    
    init(image: UIImage ,description: String?) {
        self.image = image
        self.cellWidth = image.size.width
        self.cellHeight = image.size.height
        self.labelTitle = description
    }
    
    init(entity: PhotoEntity?) {
        self.entityData = entity
        guard let entity = entityData, let imageData = entity.photoImage, let image = UIImage(data: imageData) else { return }
        self.image = image
        self.cellWidth = CGFloat(entity.width)
        self.cellHeight = CGFloat(entity.height)
        self.labelTitle = entity.des
    }
}
