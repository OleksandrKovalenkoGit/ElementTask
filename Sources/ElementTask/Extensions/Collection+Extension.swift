import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    func element(at index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
