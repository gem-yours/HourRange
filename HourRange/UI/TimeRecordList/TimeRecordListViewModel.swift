//

import UIKit
import RxSwift
import RxRelay


class TimeRecordListViewModel {
    let timeRecordRepository: TimeRecordRepository
    var timeRecordsEvent = BehaviorSubject(value: [TimeRecord]())
    var error = BehaviorRelay(value: nil as RepositoryError?)
    
    init() {
        self.timeRecordRepository = Dependencies.shared.container.resolve(TimeRecordRepository.self)!
        fetch()
    }
    
    func fetch() {
        timeRecordRepository.getAll { [weak self] in
            switch $0 {
            case .success(let timeRecords):
                self?.timeRecordsEvent.onNext(timeRecords)
            case .failure(let error):
                self?.error.accept(error)
            }
        }
    }
}
