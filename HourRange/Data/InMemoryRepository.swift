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
    
    public func add(timeRecord: TimeRecord) {
        timeRecords.append(timeRecord)
    }
    
    public func update(timeRecord: TimeRecord) {
        guard let index = timeRecords.firstIndex(where: { $0 == timeRecord }) else {
            return
        }
        timeRecords[index] = timeRecord
    }
    
    public func delete(timeRecord: TimeRecord) {
        timeRecords.removeAll(where: { $0 == timeRecord })
    }
}
