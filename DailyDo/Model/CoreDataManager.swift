import UIKit
import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리)

final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "MemoEntity"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getMemoListFromCoreData() -> [MemoEntity] {
        var memoList: [MemoEntity] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [MemoEntity] {
                    memoList = fetchedToDoList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        
        return memoList
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveMemoEntity(memoText: String?, memoCycle: Int16, firstTime: String, secondTime: String, isFirst: Bool,
                        completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                if let memoEntity = NSManagedObject(entity: entity, insertInto: context) as? MemoEntity {
                    
                    // MARK: - ToDoData에 실제 데이터 할당 ⭐️
                    memoEntity.memo = memoText
                    memoEntity.date = Date()
                    // 날짜는 저장하는 순간의 날짜로 생성
                    memoEntity.cycle = memoCycle
                    memoEntity.firstTime = firstTime
                    memoEntity.secondTime = secondTime
                    memoEntity.isFirst = isFirst
                    memoEntity.isDone = false
                    
                    
                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    func deleteMemo(data: MemoEntity, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = data.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [MemoEntity] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetMemo = fetchedToDoList.first {
                        context.delete(targetMemo)
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateMemo(newMemoEntity: MemoEntity, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newMemoEntity.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedMemoList = try context.fetch(request) as? [MemoEntity] {
                    // 배열의 첫번째
                    if var targetMemo = fetchedMemoList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetMemo = newMemoEntity
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
}
