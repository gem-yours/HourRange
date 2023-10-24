import Foundation


public class InmemoryTimeRecordRepository: TimeRecordRepository {
    private var timeRecords = [TimeRecord]()
    
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
