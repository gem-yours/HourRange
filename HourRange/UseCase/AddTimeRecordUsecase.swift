//

import Foundation

struct AddTimeRecordUsecase {
    let repository: TimeRecordRepository
    
    func invoke(timeRecord: TimeRecord) throws {
        do {
            try repository.update(timeRecord: timeRecord)
        } catch RepositoryError.notExist {
            try repository.add(timeRecord: timeRecord)
        }
    }
}
