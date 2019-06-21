//
//  EJFiveDaysWind.swift
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EJFiveDaysWind: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let speed = "speed"
    static let deg = "deg"
  }

  // MARK: Properties
  public var speed: Float?
  public var deg: Float?

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
    speed = json[SerializationKeys.speed].float
    deg = json[SerializationKeys.deg].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = speed { dictionary[SerializationKeys.speed] = value }
    if let value = deg { dictionary[SerializationKeys.deg] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.speed = aDecoder.decodeObject(forKey: SerializationKeys.speed) as? Float
    self.deg = aDecoder.decodeObject(forKey: SerializationKeys.deg) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(speed, forKey: SerializationKeys.speed)
    aCoder.encode(deg, forKey: SerializationKeys.deg)
  }

}
