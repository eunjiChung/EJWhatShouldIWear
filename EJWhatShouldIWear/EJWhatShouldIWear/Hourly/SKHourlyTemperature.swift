//
//  SKHourlyTemperature.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKHourlyTemperature: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tmax = "tmax"
    static let tmin = "tmin"
    static let tc = "tc"
  }

  // MARK: Properties
  public var tmax: String?
  public var tmin: String?
  public var tc: String?

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
    tc = json[SerializationKeys.tc].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tmax { dictionary[SerializationKeys.tmax] = value }
    if let value = tmin { dictionary[SerializationKeys.tmin] = value }
    if let value = tc { dictionary[SerializationKeys.tc] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.tmax = aDecoder.decodeObject(forKey: SerializationKeys.tmax) as? String
    self.tmin = aDecoder.decodeObject(forKey: SerializationKeys.tmin) as? String
    self.tc = aDecoder.decodeObject(forKey: SerializationKeys.tc) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(tmax, forKey: SerializationKeys.tmax)
    aCoder.encode(tmin, forKey: SerializationKeys.tmin)
    aCoder.encode(tc, forKey: SerializationKeys.tc)
  }

}
