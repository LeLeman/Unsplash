//
//  Image.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 18.09.2022.
//

import Foundation
import CoreData
import UIKit 


@objc (Picture)
class Picture: NSManagedObject {
 
    @nonobjc private func fechtResualt() -> NSFetchRequest<Picture> {
        return NSFetchRequest<Picture>(entityName: "Image")
    }
    
    @NSManaged public var content: UIImage?
}

extension Picture : Identifiable {
    
}
