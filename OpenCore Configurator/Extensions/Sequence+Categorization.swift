extension Sequence {
    /// Categorizes elements of self into a dictionary, with the keys returned from the closure.
    ///
    /// - Parameter key: Hashable key that you wish to categorize by.
    /// - Returns: Dictionary of objects grouped by the passed key.
    func categorize<T>(_ key: (Element) -> T) -> [T: [Element]] {
        var dict: [T: [Element]] = [:]
        for el in self {
            let key = key(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }

    /// Categorizes elements of self into a dictionary, with the keys returned from the specified key path.
    ///
    /// - Parameter keyPath: KeyPath that you with to categorize by.
    /// - Returns: Dictionary of objects grouped by the passed key.
    func categorize<T>(_ keyPath: KeyPath<Element, T>) -> [T: [Element]] {
        var dict: [T: [Element]] = [:]
        for el in self {
            let key = el[keyPath: keyPath]
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
}
