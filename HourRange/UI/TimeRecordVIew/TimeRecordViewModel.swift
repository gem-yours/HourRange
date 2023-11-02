//

import Foundation

public class TimeRecordViewModel {
    public private(set) var timeRecord: TimeRecord
    private let timeRecordRepository: TimeRecordRepository
    weak var timeRecordView: TimeRecordView?
    
    init(
        timeRecord: TimeRecord? = nil,
        timeRecordRepository: TimeRecordRepository
        
    ) {
        self.timeRecord = timeRecord ?? TimeRecord(start: 0, end: 0, hour: 0)
        self.timeRecordRepository = timeRecordRepository
    }
    
    func save() {
        guard let startHour = Hour(value: Int(timeRecordView?.startHour)),
              let endHour = Hour(value: Int(timeRecordView?.endHour)),
              let hour = Hour(value: Int(timeRecordView?.hour)) else {
            timeRecordView?.showToast(message: "入力内容を確認してください")
            return
        }
        timeRecord.start = startHour
        timeRecord.end = endHour
        timeRecord.hour = hour
        timeRecordRepository.add(timeRecord: timeRecord) { [weak self] in
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
