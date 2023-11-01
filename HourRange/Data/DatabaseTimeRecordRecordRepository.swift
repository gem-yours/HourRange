//

import Foundation
import Realm
import RealmSwift


public struct DatabaseTimeRecordRepository: TimeRecordRepository {
    public static let shared = DatabaseTimeRecordRepository()
    private init() { }
    
    public func getAll(completion: @escaping ((Result<[TimeRecord], RepositoryError>) -> Void)) {
        DispatchQueue.global().async {
            let result = _getAll()
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private func _getAll() -> Result<[TimeRecord], RepositoryError> {
        switch instantiateRealm() {
        case .success(let realm):
            let timeRecords = realm.objects(TimeRecordModel.self).compactMap {
                $0.timeRecord
            }
            return .success(Array(timeRecords))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func add(timeRecord: TimeRecord, completion: ((Result<TimeRecord, RepositoryError>) -> Void)?) {
        DispatchQueue.global().async {
            let result = _add(timeRecord: timeRecord)
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }

    private func _add(timeRecord: TimeRecord) -> Result<TimeRecord, RepositoryError> {
        switch instantiateRealm() {
        case .success(let realm):
            do {
                try realm.write {
                    realm.add(timeRecord.model)
                }
            } catch (let error) {
                return .failure(.databaseError(error.localizedDescription))
            }
        case .failure(let error):
            return .failure(error)
        }
        return .failure(.unknown)
    }
    
    public func delete(timeRecord: TimeRecord, completion: ((Result<TimeRecord, RepositoryError>) -> Void)?) {
        DispatchQueue.global().async {
            let result = _delete(timeRecord: timeRecord)
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }

    private func _delete(timeRecord: TimeRecord) -> Result<TimeRecord, RepositoryError> {
        switch instantiateRealm() {
        case .success(let realm):
            do {
                try realm.write {
                    realm.delete(timeRecord.model)
                }
            } catch (let error) {
                return .failure(.databaseError(error.localizedDescription))
            }
        case .failure(let error):
            return .failure(error)
        }
        return .failure(.unknown)
    }

    
    private func instantiateRealm() -> Result<Realm, RepositoryError> {
        do {
            let realm = try Realm()
            return .success(realm)
        } catch(let error) {
            return .failure(.databaseError(error.localizedDescription))
        }
    }
}


class TimeRecordModel: RealmSwiftObject {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var start: Int
    @Persisted var end: Int
    @Persisted var hour: Int
    @Persisted var isContained: Bool
    
    convenience init(id: String, start: Int, end: Int, hour: Int, isContained: Bool) {
        self.init()
        self.id = id
        self.start = start
        self.end = end
        self.hour = hour
        self.isContained = isContained
    }
}

extension TimeRecordModel {
    var timeRecord: TimeRecord? {
        guard let startHour = Hour(value: start),
              let endHour = Hour(value: end),
              let hour = Hour(value: self.hour) else {
            return nil
        }
        return TimeRecord(start: startHour, end: endHour, hour: hour)
    }
}

extension TimeRecord {
    var model: TimeRecordModel {
        TimeRecordModel(id: id.uuidString, start: start.value, end: end.value, hour: hour.value, isContained: isContained)
    }
}
