//
//  SKYesterdayYesterday.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKYesterdayYesterday: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let grid = "grid"
    static let day = "day"
  }

  // MARK: Properties
  public var grid: SKYesterdayGrid?
  public var day: SKYesterdayDay?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    grid = SKYesterdayGrid(json: json[SerializationKeys.grid])
    day = SKYesterdayDay(json: json[SerializationKeys.day])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = grid { dictionary[SerializationKeys.grid] = value.dictionaryRepresentation() }
    if let value = day { dictionary[SerializationKeys.day] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.grid = aDecoder.decodeObject(forKey: SerializationKeys.grid) as? SKYesterdayGrid
    self.day = aDecoder.decodeObject(forKey: SerializationKeys.day) as? SKYesterdayDay
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(grid, forKey: SerializationKeys.grid)
    aCoder.encode(day, forKey: SerializationKeys.day)
  }

}
