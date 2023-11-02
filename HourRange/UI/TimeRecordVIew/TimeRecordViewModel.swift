//

import Foundation
import RxSwift
import RxRelay

public class TimeRecordViewModel {
    public var timeRecord: BehaviorRelay<TimeRecord>
    private let timeRecordRepository: TimeRecordRepository
    
    private var disposeBag = DisposeBag()
    weak var timeRecordView: TimeRecordView? {
        didSet {
            guard let timeRecordView = timeRecordView else {
                return
            }
            Observable
                .combineLatest(timeRecordView.startHour, timeRecordView.endHour, timeRecordView.hour)
                .subscribe { start, end, hour in
                    var timeRecord = self.timeRecord.value
                    if let startHour = Hour(value: Int(start)) {
                        timeRecord.start = startHour
                    }
                    if let endHour = Hour(value: Int(end)) {
                        timeRecord.end = endHour
                    }
                    if let newHour = Hour(value: Int(hour)) {
                        timeRecord.end = newHour
                    }
                    self.timeRecord.accept(timeRecord)
                }
                .disposed(by: disposeBag)
        }
    }
    
    init(timeRecord: TimeRecord? = nil) {
        self.timeRecord = BehaviorRelay(value: timeRecord ?? TimeRecord(start: 0, end: 0, hour: 0))
        self.timeRecordRepository = Dependencies.shared.container.resolve(TimeRecordRepository.self)!
    }
    
    func save() {
        timeRecordRepository.add(timeRecord: timeRecord.value) { [weak self] in
            switch $0 {
            case .success:
                self?.timeRecordView?.showToast(message: "保存に成功しました")
            case .failure(let error):
                self?.timeRecordView?.showToast(message: error.localizedDescription)
            }
        }
    }
}


extension Int {
    init?(_ string: String?) {
        guard let string = string else {
            return nil
        }
        guard let value = Int(string) else {
            return nil
        }
        self = value
    }
}
