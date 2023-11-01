//

import UIKit


struct TimeRecordListViewModel {
    let timeRecordRepository: TimeRecordRepository
    var timeRecords: [TimeRecord] {
        timeRecordRepository.getAll()
    }
    
    init(timeRecordRepository: TimeRecordRepository) {
        self.timeRecordRepository = timeRecordRepository
    }
}
