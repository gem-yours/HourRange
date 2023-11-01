import Foundation


public class InmemoryTimeRecordRepository: TimeRecordRepository {
    public static var shared = InmemoryTimeRecordRepository()
    private var timeRecords = [
        TimeRecord(start: 0, end: 24, hour: 0),
        TimeRecord(start: 6, end: 18, hour: 12),
        TimeRecord(start: 5, end: 22, hour: 24)
    ]
    
    
    public func getAll(completion: ((Result<[TimeRecord], RepositoryError>) -> Void)) {
        completion(.success(timeRecords))
    }
    
    public func add(timeRecord: TimeRecord, completion: ((Result<TimeRecord, RepositoryError>) -> Void)?) {
        guard timeRecords.firstIndex(where: { $0.id == timeRecord.id }) == nil else {
            completion?(.success(timeRecord))
            return
        }
        timeRecords.append(timeRecord)
        completion?(.success(timeRecord))
    }
    
    public func delete(timeRecord: TimeRecord, completion: ((Result<TimeRecord, RepositoryError>) -> Void)?) {
        timeRecords.removeAll(where: { $0 == timeRecord })
        completion?(.success(timeRecord))
    }
}
