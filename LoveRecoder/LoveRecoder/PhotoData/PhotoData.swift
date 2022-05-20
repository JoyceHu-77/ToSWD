//
//  PhotoData.swift
//  LoveRecoder
//
//  Created by Blacour on 2022/1/3.
//

import UIKit
import CoreData

class PhotoData: NSObject {
    
    lazy var coreDataStack = CoreDataStack(modelName: "PhotoRecoder")
    
    var entityArray = [PhotoEntity]()

    
    func fetchRequestEntity() -> [PhotoEntity]{
        let entityFetch: NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()
        do {
            let results = try coreDataStack.managedContext.fetch(entityFetch)
            entityArray = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return entityArray
    }
    
    func addPhotoData(image: UIImage, des: String ) {
//        let pngImageData = image.pngData()
        let pngImageData = image.jpegData(compressionQuality: 1.0)
        
        let currentEntity = PhotoEntity(context: coreDataStack.managedContext)
        currentEntity.photoImage = pngImageData
        currentEntity.des = des
        coreDataStack.saveContext()
        entityArray.append(currentEntity)
    }
    
    func delete(at row: Int) {
//        coreDataStack.managedContext.delete(all)
//        coreDataStack.saveContext()
    }

}
