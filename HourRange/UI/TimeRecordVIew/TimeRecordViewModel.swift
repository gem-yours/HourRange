//

import Foundation

public struct TimeRecordViewModel {
    let timeRecordRepository: TimeRecordRepository
    var timeRecord = TimeRecord(start: 0, end: 0, hour: 0)
    
    init(timeRecordRepository: TimeRecordRepository) {
        self.timeRecordRepository = timeRecordRepository
    }
}
