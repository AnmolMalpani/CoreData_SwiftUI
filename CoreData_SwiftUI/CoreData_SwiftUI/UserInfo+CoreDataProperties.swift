//
//  UserInfo+CoreDataProperties.swift
//  CoreData_SwiftUI
//
//  Created by Anmol Maheshwari on 10/05/20.
//  Copyright © 2020 Anmol Maheshwari. All rights reserved.
//
//

import Foundation
import CoreData

extension UserInfo {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }
    
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var gender: String
}
