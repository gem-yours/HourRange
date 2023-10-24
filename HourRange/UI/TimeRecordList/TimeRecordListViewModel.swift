//

import UIKit


struct TimeRecordListViewModel {
    let timeRecordRepository: TimeRecordRepository
    var timeRecords = [TimeRecord]()
    
    init(timeRecordRepository: TimeRecordRepository) {
        self.timeRecordRepository = timeRecordRepository
        timeRecords = timeRecordRepository.getAll()
    }
}
