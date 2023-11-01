//

import Foundation


public struct TimeRecord: Identifiable, Equatable {
    public let id = UUID()
    public var start: Hour
    public var end: Hour
    public var hour: Hour
    
    public var isContained: Bool {
        if start == end {
            return start == hour
        } else if start < end {
            return (start..<end).contains(hour)
        } else {
            return !(end..<start).contains(hour)
        }
    }
}

public struct Hour: ExpressibleByIntegerLiteral, Comparable {
    let value: Int
    
    public init?(value: Int?) {
        guard let value = value else {
            return nil
        }
        guard value >= 0,
              value <= 24 else {
            return nil
        }
        self.value = value
    }
    
    public init(integerLiteral value: Int) {
        guard let hour = Hour(value: value) else {
            fatalError("\(value) is invalid.")
        }
        self = hour
    }
    
    public static func < (lhs: Hour, rhs: Hour) -> Bool {
        lhs.value < rhs.value
    }
}
