//

import Foundation

public protocol TimeRecordRepository {
    func getAll(completion: @escaping ((Result<[TimeRecord], RepositoryError>) -> Void))
    func add(timeRecord: TimeRecord, completion: ((Result<TimeRecord, RepositoryError>) -> Void)?)
    func delete(timeRecord: TimeRecord, completion: ((Result<TimeRecord, RepositoryError>) -> Void)?)
}

extension TimeRecordRepository {
    func add(timeRecord: TimeRecord) {
        add(timeRecord: timeRecord, completion: nil)
    }
    func delete(timeRecord: TimeRecord) {
        delete(timeRecord: timeRecord, completion: nil)
    }
}


public enum RepositoryError: LocalizedError {
    case notExist
    case databaseError(String)
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .notExist:
            return "該当のデータが見つかりませんでした"
        case .databaseError:
            return "データベースでエラーが発生しました"
        case .unknown:
            return "原因不明のエラーが発生しました"
        }
    }
}
