//

import Foundation

public protocol TimeRecordRepository {
    func getAll() -> [TimeRecord]
    func add(timeRecord: TimeRecord)
    func update(timeRecord: TimeRecord)
    func delete(timeRecord: TimeRecord)
}
