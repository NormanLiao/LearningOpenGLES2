/// A type representing a choice between two values: left and right.
public protocol EitherType {
  // swiftlint:disable type_name
  associatedtype A
  associatedtype B
  // swiftlint:enable type_name

  /**
   Create an `Either` value from a left value.

   - parameter left: A left value.

   - returns: An `Either` value.
   */
  init(left: A)

  /**
   Create an `Either` value from a right value.

   - parameter right: A right value.

   - returns: An `Either` value.
   */
  init(right: B)

  /**
   Create an `Either` value from a value. Only works when `A != B`.

   - parameter left: A value.

   - returns: An `Either` value.
   */
  init(_ left: A)

  /**
   Creates an `Either` value from a value. Only works when `A != B`.

   - parameter right: A value.

   - returns: An `Either` value
   */
  init(_ right: B)

  /// Get an optional left value out of an `Either` value.
  var left: A? { get }

  /// Get an optional right value out of an `Either` value.
  var right: B? { get }
}

extension EitherType {
  /**
   Extracts the `left` value from an either.

   - parameter e: An either type.

   - returns: A value of type `A` if `e` is a left either, `nil` otherwise.
   */
  public static func left(_ e: Self) -> A? {
    return e.left
  }

  /**
   Extracts the `right` value from an either.

   - parameter e: An either type.

   - returns: A value of type `B` if `e` is a right either, `nil` otherwise.
   */
  public static func right(_ e: Self) -> B? {
    return e.right
  }

  /// `true` if `self` is a left either, `false` otherwise.
  public var isLeft: Bool {
    return self.left != nil
  }

  /// `true` if `self` is a right either, `false` otherwise.
  public var isRight: Bool {
    return self.right != nil
  }
}

public func == <E: EitherType> (lhs: E, rhs: E) -> Bool where E.A: Equatable, E.B: Equatable {
  if let lhs = lhs.left, let rhs = rhs.left {
    return lhs == rhs
  } else if let lhs = lhs.right, let rhs = rhs.right {
    return lhs == rhs
  }
  return false
}

/**
 Returns true if the `Either` value is a left value.

 - parameter either: An `Either` value.

 - returns: A `Bool` value.
 */
public func isLeft <E: EitherType> (_ either: E) -> Bool {
  return either.isLeft
}

/**
 Returns true if the `Either` value is a right value.

 - parameter either: An `Either` value.

 - returns: A `Bool` value.
 */
public func isRight <E: EitherType> (_ either: E) -> Bool {
  return either.isRight
}

/**
 Returns all the left values from an array of `Either`s.

 - parameter eithers: An array of `Either`s.

 - returns: An array of left values.
 */
public func lefts <E: EitherType> (_ eithers: [E]) -> [E.A] {
  return eithers.map { $0.left }.compact()
}

/**
 Returns all the right values from an array of `Either`s.

 - parameter eithers: An array of `Either`s.

 - returns: An array of right values.
 */
public func rights <E: EitherType> (_ eithers: [E]) -> [E.B] {
  return eithers.map { $0.right }.compact()
}

