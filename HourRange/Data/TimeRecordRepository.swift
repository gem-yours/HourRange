//

import Foundation

public protocol TimeRecordRepository {
    func getAll() -> [TimeRecord]
    func add(timeRecord: TimeRecord) throws
    func update(timeRecord: TimeRecord) throws
    func delete(timeRecord: TimeRecord) throws
}


public enum RepositoryError: LocalizedError {
    case notExist
    case alreadyExist
    
    public var errorDescription: String? {
        switch self {
        case .notExist:
            return "該当のデータが見つかりませんでした"
        case .alreadyExist:
            return "すでにデータが存在しています"
        }
    }
}
