//

import Foundation

public struct TimeRecordViewModel {
    let timeRecordRepository: TimeRecordRepository
    weak var timeRecordView: TimeRecordView?
    
    init(timeRecordRepository: TimeRecordRepository) {
        self.timeRecordRepository = timeRecordRepository
    }
    
    func save() {
        guard let startHour = Hour(value: Int(timeRecordView?.startHour)),
              let endHour = Hour(value: Int(timeRecordView?.endHour)),
              let hour = Hour(value: Int(timeRecordView?.hour)) else {
            // TODO: 入力内容を確認し直すようにメッセージを出す
            return
        }
        let timeRecord = TimeRecord(start: startHour, end: endHour, hour: hour)
        timeRecordRepository.add(timeRecord: timeRecord)
        // TODO: 保存に成功したというメッセージを出す
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
