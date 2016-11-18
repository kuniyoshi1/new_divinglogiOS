//
//  Divinglog+CoreDataProperties.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/11/17.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import Foundation
import CoreData


extension Divinglog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Divinglog> {
        return NSFetchRequest<Divinglog>(entityName: "Divinglog");
    }

    @NSManaged public var point: String?
    @NSManaged public var title: String?
    @NSManaged public var bady: String?
    @NSManaged public var wether: String?
    @NSManaged public var tmp: String?
    @NSManaged public var utmp: String?
    @NSManaged public var weit: String?
    @NSManaged public var suit: String?
    @NSManaged public var depth: String?
    @NSManaged public var mdepth: String?
    @NSManaged public var pres: String?
    @NSManaged public var mpres: String?
    @NSManaged public var stime: String?
    @NSManaged public var ftime: String?
    @NSManaged public var memo: String?
    @NSManaged public var memo2: String?

}
