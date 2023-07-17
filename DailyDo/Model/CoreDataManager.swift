//
//  CoreDataManager.swift
//  DailyDo
//
//  Created by Soo Jang on 2023/07/05.
//
import CoreData
import Foundation

struct Memo: Codable, Equatable {
    var isFirst: Bool
    var cycle: Int16
    var firstTime: Int64
    var secondTime: Int64
    var memoText: String
    var date: Date
}

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoredataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "MemoEntity", in: context)
    }
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchMemo() -> [MemoEntity] {
        do {
            let request = MemoEntity.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func insertMemo(_ memo: Memo) {
        if let entity = memoEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(memo.isFirst, forKey: "isFirst")
            managedObject.setValue(memo.cycle, forKey: "cycle")
            managedObject.setValue(memo.firstTime, forKey: "firstTime")
            managedObject.setValue(memo.secondTime, forKey: "secondTime")
            managedObject.setValue(memo.memoText, forKey: "memo")
            managedObject.setValue(memo.date, forKey: "date")
            saveToContext()
        }
    }
    
    func getMemo() -> [Memo] {
        var memos: [Memo] = []
        let fetchResults = fetchMemo()
        for result in fetchResults {
            let memoCyle = Memo(
                isFirst: result.isFirst,
                cycle: result.cycle,
                firstTime: result.firstTime,
                secondTime: result.secondTime,
                memoText: result.memo ?? "",
                date: result.date ?? Date()
            )
            memos.append(memoCyle)
        }
        return memos
    }
    
//    func updateMemo(_ memoCycle: MemoCycle) {
//        let fetchResults = fetchMemo()
//        for result in fetchResults {
//            if result.url == notice.url {
//                result.title = "업데이트한 제목"
//            }
//        }
//        saveToContext()
//    }
    
    func deleteMemo(_ memo: Memo) {
        let fetchResults = fetchMemo()
        let memo = fetchResults.filter({ $0.memo == memo.memoText })[0]
        context.delete(memo)
        saveToContext()
    }
    
//    func deleteAllBookmarks() {
//        let fetchResults = fetchMemo()
//        for result in fetchResults {
//            context.delete(result)
//        }
//        saveToContext()
//    }
}
