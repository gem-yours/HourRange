//

import UIKit


class TimeRecordListViewModel {
    let timeRecordRepository: TimeRecordRepository
    var timeRecords = [TimeRecord]()
    
    init(timeRecordRepository: TimeRecordRepository) {
        self.timeRecordRepository = timeRecordRepository
        fetch()
    }
    
    func fetch() {
        timeRecordRepository.getAll { [weak self] in
            switch $0 {
            case .success(let timeRecords):
                self?.timeRecords = timeRecords
            case .failure:
                // TODO: エラーの表示
                break
            }
        }
    }
}
