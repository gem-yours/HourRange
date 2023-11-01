//

import Foundation

public struct TimeRecordViewModel {
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
    
    mutating func save() {
        guard let startHour = Hour(value: Int(timeRecordView?.startHour)),
              let endHour = Hour(value: Int(timeRecordView?.endHour)),
              let hour = Hour(value: Int(timeRecordView?.hour)) else {
            // TODO: 入力内容を確認し直すようにメッセージを出す
            return
        }
        timeRecord.start = startHour
        timeRecord.end = endHour
        timeRecord.hour = hour
        do {
            try AddTimeRecordUsecase(repository: timeRecordRepository).invoke(timeRecord: timeRecord)
        } catch(let error) {
            // TODO: エラーの表示
            print(error)
        }
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
