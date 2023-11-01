import Foundation


public class InmemoryTimeRecordRepository: TimeRecordRepository {
    public static var shared = InmemoryTimeRecordRepository()
    private var timeRecords = [
        TimeRecord(start: 0, end: 24, hour: 0),
        TimeRecord(start: 6, end: 18, hour: 12),
        TimeRecord(start: 5, end: 22, hour: 24)
    ]
    
    public func getAll() -> [TimeRecord] {
        timeRecords
    }
    
    public func add(timeRecord: TimeRecord) throws {
        guard timeRecords.firstIndex(where: { $0.id == timeRecord.id }) == nil else {
            throw RepositoryError.alreadyExist
        }
        timeRecords.append(timeRecord)
    }
    
    public func update(timeRecord: TimeRecord) throws {
        guard let index = timeRecords.firstIndex(where: { $0.id == timeRecord.id }) else {
            throw RepositoryError.notExist
        }
        timeRecords[index] = timeRecord
    }
    
    public func delete(timeRecord: TimeRecord) {
        timeRecords.removeAll(where: { $0 == timeRecord })
    }
}
