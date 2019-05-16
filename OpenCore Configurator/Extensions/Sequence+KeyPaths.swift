extension Sequence {
    /// Returns an array containing the results of mapping the value of the given key path from each of the sequence’s elements.
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }

    /// Returns an array containing the non-nil results of mapping the value of the given key path from each of the sequence’s elements.
    func compactMap<T>(_ keyPath: KeyPath<Element, T?>) -> [T] {
        return compactMap { $0[keyPath: keyPath] }
    }

    /// Group the elements of this sequence based on the passed key path.
    func grouped<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [T: [Element]] {
        return .init(grouping: self, by: { $0[keyPath: keyPath] })
    }

    /// Sets the provided value on the specified property of each element of the sequence.
    func setEach<T>(_ keyPath: ReferenceWritableKeyPath<Element, T>, to value: T) {
        forEach { $0[keyPath: keyPath] = value }
    }

    /// Returns the elements of the sequence, sorted using the value of the given key path as the comparison between elements.
    ///
    /// - Parameter keyPath: Key path upon which to sort.
    /// - Returns: Sorted elements of the sequence.
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
