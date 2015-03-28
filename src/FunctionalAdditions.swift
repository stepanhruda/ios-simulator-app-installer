public func flatMap<T, U>(f: T -> U?)(optional: T?) -> U? {
    switch optional {
    case .None: return .None
    case .Some(let value): return f(value)
    }
}

public func map<T, U>(f: T -> U)(optional: T?) -> U? {
    switch optional {
    case .None: return .None
    case .Some(let value): return f(value)
    }
}

public func filteredWithPredicate<S : SequenceType>
    (includeElement: (S.Generator.Element) -> Bool)
    (source: S)
    -> [S.Generator.Element] {
        return filter(source, includeElement)
}

infix operator |>    { precedence 50 associativity left }
infix operator >>=   { precedence 50 associativity left }

public func |> <T,U>(lhs: T, rhs: T -> U) -> U {
    return rhs(lhs)
}

public func >>= <T,U>(lhs: T?, rhs: T -> U?) -> U? {
    return flatMap(rhs)(optional: lhs)
}
