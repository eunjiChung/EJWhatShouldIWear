//
//  EJMain.swift
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EJMain: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let humidity = "humidity"
    static let tempMin = "temp_min"
    static let tempMax = "temp_max"
    static let temp = "temp"
    static let pressure = "pressure"
  }

  // MARK: Properties
  public var humidity: Int?
  public var tempMin: Float?
  public var tempMax: Float?
  public var temp: Float?
  public var pressure: Int?

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
    humidity = json[SerializationKeys.humidity].int
    tempMin = json[SerializationKeys.tempMin].float
    tempMax = json[SerializationKeys.tempMax].float
    temp = json[SerializationKeys.temp].float
    pressure = json[SerializationKeys.pressure].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = humidity { dictionary[SerializationKeys.humidity] = value }
    if let value = tempMin { dictionary[SerializationKeys.tempMin] = value }
    if let value = tempMax { dictionary[SerializationKeys.tempMax] = value }
    if let value = temp { dictionary[SerializationKeys.temp] = value }
    if let value = pressure { dictionary[SerializationKeys.pressure] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.humidity = aDecoder.decodeObject(forKey: SerializationKeys.humidity) as? Int
    self.tempMin = aDecoder.decodeObject(forKey: SerializationKeys.tempMin) as? Float
    self.tempMax = aDecoder.decodeObject(forKey: SerializationKeys.tempMax) as? Float
    self.temp = aDecoder.decodeObject(forKey: SerializationKeys.temp) as? Float
    self.pressure = aDecoder.decodeObject(forKey: SerializationKeys.pressure) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(humidity, forKey: SerializationKeys.humidity)
    aCoder.encode(tempMin, forKey: SerializationKeys.tempMin)
    aCoder.encode(tempMax, forKey: SerializationKeys.tempMax)
    aCoder.encode(temp, forKey: SerializationKeys.temp)
    aCoder.encode(pressure, forKey: SerializationKeys.pressure)
  }

}
