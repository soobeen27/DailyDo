//
//  MemoEntity+CoreDataProperties.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/18.
//
//
import Foundation
import CoreData


extension MemoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoEntity> {
        return NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
    }

    @NSManaged public var cycle: Int16
    @NSManaged public var firstTime: String?
    @NSManaged public var isFirst: Bool
    @NSManaged public var memo: String?
    @NSManaged public var secondTime: String?
    @NSManaged public var date: Date?
    @NSManaged public var isDone: Bool
    
    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    var identifier: URL {
        let id = self.objectID.uriRepresentation()
        return id
    }

}

extension MemoEntity : Identifiable {

}
