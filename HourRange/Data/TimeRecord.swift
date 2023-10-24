//

import Foundation


public struct TimeRecord: Identifiable, Equatable {
    public let id = UUID()
    public var start: Hour
    public var end: Hour
    public var hour: Hour
    
    public var isContained: Bool {
        switch (start.value - end.value) {
        case 0:
            return start == hour
        case ..<0:
            return isContainedWhenStartLesserThanEnd()
        default:
            return isContainedWhenStartGreaterThanEnd()
        }
    }
    
    private func isContainedWhenStartLesserThanEnd() -> Bool {
        (start..<end).contains(hour)
    }
    
    private func isContainedWhenStartGreaterThanEnd() -> Bool {
        !(end..<start).contains(hour)
    }
}

public struct Hour: ExpressibleByIntegerLiteral, Comparable {
    let value: Int
    
    public init?(value: Int) {
        guard value >= 0,
              value <= 24 else {
            return nil
        }
        self.value = value
    }
    
    public init(integerLiteral value: Int) {
        guard let hour = Hour(value: value) else {
            // このメソッドはリテラルによる呼び出ししか行われないので、fatalErrorだが許容する
            fatalError("\(value) is invalid.")
        }
        self = hour
    }
    
    public static func < (lhs: Hour, rhs: Hour) -> Bool {
        lhs.value < rhs.value
    }
}
