import Foundation

extension String {
    var localized: Self { NSLocalizedString(self, comment: "") }
}

extension String {
    struct RegexResult {
        let matches: [String]
        let lastIndex: Int?
    }

    /// Returns converted to `String` matches of the pattern starting from `location`.
    func regexMatches(for pattern: String, from location: Int = .zero) throws -> RegexResult {
        var lastIndex: Int?

        let expression = try NSRegularExpression(pattern: pattern)
        let matches: [String] = expression.matches(
            in: self,
            range: .init(location: location, length: count - location)
        )
        .compactMap {
            lastIndex = $0.range.upperBound - 1
            return Range($0.range, in: self).map { String(self[$0]) }
        }
        return .init(matches: matches, lastIndex: lastIndex)
    }
}
