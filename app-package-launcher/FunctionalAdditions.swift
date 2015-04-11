public func map<A,B>(f: A -> B)(optional: A?) -> B? {
    switch optional {
    case .None: return .None
    case .Some(let value): return f(value)
    }
}

public func map<A,B>(f: A -> B)(source: [A]) -> [B] {
    return map(source, f)
}

public func flatten<A>(optional: A??) -> A? {
    switch optional {
    case .None: return .None
    case .Some(let value): return value
    }
}

public func bind<A,B>(f: A -> B?)(optional: A?) -> B? {
    return flatten(map(f)(optional: optional))
}

public func compose<A,B,C>(g: B -> C)(f: A -> B)(a: A) -> C {
    return g(f(a))
}

public func bindCompose<A,B,C>(g: B -> C?)(f: A -> B?)(optional: A?) -> C? {
    return flatten(map(g)(optional: flatten(map(f)(optional: optional))))
}

public func filteredWithPredicate<S : SequenceType>
    (includeElement: (S.Generator.Element) -> Bool)
    (source: S)
    -> [S.Generator.Element] {
        return filter(source, includeElement)
}

public func sorted<C : SequenceType>(isOrderedBefore: (C.Generator.Element, C.Generator.Element) -> Bool)(source: C) -> [C.Generator.Element] {
    return sorted(source, isOrderedBefore)
}

infix operator |>    { associativity left precedence 150 }
infix operator >>=   { associativity left precedence 150 }
infix operator >+>   { associativity left precedence 150 }
infix operator >=>   { associativity left precedence 150 }

public func |> <A,B>(lhs: A, rhs: A -> B) -> B {
    return rhs(lhs)
}

public func >>= <A,B>(lhs: A?, rhs: A -> B?) -> B? {
    return bind(rhs)(optional: lhs)
}

public func >+> <A,B,C>(lhs: A -> B, rhs: B -> C) -> (A -> C) {
    return compose(rhs)(f: lhs)
}

public func >=> <A,B,C>(lhs: A -> B?, rhs: B -> C?) -> (A -> C?) {
    return { bindCompose(rhs)(f: lhs)(optional: $0) }
}
