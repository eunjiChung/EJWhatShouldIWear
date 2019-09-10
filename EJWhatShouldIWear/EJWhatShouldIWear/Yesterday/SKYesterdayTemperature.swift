//
//  SKYesterdayTemperature.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKYesterdayTemperature: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tmax = "tmax"
    static let tmin = "tmin"
  }

  // MARK: Properties
  public var tmax: String?
  public var tmin: String?

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
    tmax = json[SerializationKeys.tmax].string
    tmin = json[SerializationKeys.tmin].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tmax { dictionary[SerializationKeys.tmax] = value }
    if let value = tmin { dictionary[SerializationKeys.tmin] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.tmax = aDecoder.decodeObject(forKey: SerializationKeys.tmax) as? String
    self.tmin = aDecoder.decodeObject(forKey: SerializationKeys.tmin) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(tmax, forKey: SerializationKeys.tmax)
    aCoder.encode(tmin, forKey: SerializationKeys.tmin)
  }

}
