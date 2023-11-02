//

import Foundation
import Swinject

public struct Dependencies {
    static let shared = Dependencies {
        let container = Container()
        container.register(TimeRecordRepository.self) { _ in 
            DatabaseTimeRecordRepository.shared
        }
        return container
    }
    
    public let container: Container
    
    public init(_ resolver: () -> Container) {
        self.container = resolver()
    }
}
