enum CronTime: Equatable {
    case value(Int)
    case any

    var value: Int? {
        switch self {
        case let .value(number): return number
        case .any: return nil
        }
    }
}
